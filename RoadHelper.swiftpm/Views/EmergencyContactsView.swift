//
//  EmergencyContactsView.swift
//  Toxapex
//
//  Created by Marco Bueno on 16/01/26.
//
import SwiftUI
import Contacts
import ContactsUI
import SwiftData

struct EmergencyContactsView: View {
    
    @Query(sort: \ContactModel.name) private var savedContacts: [ContactModel]
    @Environment(\.modelContext) private var modelContext
    
    let impact = UIImpactFeedbackGenerator(style: .light)

    @State private var contactToDelete : ContactModel?
    @State private var showDeleteAlert: Bool = false
    @State private var contactManager = ContactManager()
    @State private var searchText = ""
    var filteredPrimaryContacts: [PrimaryContact] {
        if searchText.isEmpty {
            return primaryContacts
        } else {
            return primaryContacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.number.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var filteredPersonalContacts: [ContactModel] {
        if searchText.isEmpty {
            return savedContacts
        } else {
            return savedContacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.number.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    @State private var showContactPicker: Bool = false
    @Environment(\.colorScheme) var colorScheme
    let colorCardEmergencyContacts = Color("AlertColor2")
    let primaryContacts = [
        PrimaryContact(
            name: "Military Police",
            number: "190",
            description: "Immediate risk situations, crimes, and hazards on the road.",
            image: "shield.fill"
        ),
        PrimaryContact(
            name: "Highway Patrol",
            number: "191",
            description: "Federal highway accidents and crimes.",
            image: "car.rear.hazardsign.fill"
        ),
        PrimaryContact(
            name: "Ambulance (SAMU)",
            number: "192",
            description: "Urgent medical assistance.",
            image: "heart.fill"
        ),
        PrimaryContact(
            name: "Fire Department",
            number: "193",
            description: "Rescue of victims and fire emergencies.",
            image: "fire.extinguisher.fill"
        )
    ]
    
    var body: some View {
        ZStack {
            let colorGradient = colorScheme == .dark ? Color("Color1").opacity(0.8) : Color("AlertColor").opacity(0.0)
            
            Color(.systemGroupedBackground).ignoresSafeArea()
            
            LinearGradient(colors: [colorGradient, .clear], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
//                    Text("Emergency Contacts")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundStyle(.primary)
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(filteredPrimaryContacts, id: \.id) { contact in
                            cardPrimaryContact(contact: contact)
                        }
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .center, spacing: 10) {
                            Text("Personal Contacts")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
//                            Button {
//                                self.showContactPicker = true
//                            }label: {
//                                Image(systemName: "plus")
//                                    .fontWeight(.semibold)
//                                    .padding(8)
//                                    .foregroundStyle(.white)
//                            }
//                            .background {
//                                Circle()
//                                    .foregroundStyle(Color("AlertColor2").opacity(1))
//                            }
                        }
                        if self.filteredPersonalContacts.isEmpty {
                            VStack(alignment: .leading,spacing: 4) {
                                Text("Add personal contacts like family or insurance for quick access.")
                                
                                Text("Tip: Include highway emergency services (0800) for your frequent routes.")
                            }
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        }
                        VStack(spacing: 8) {
                            ForEach(self.filteredPersonalContacts, id: \.self.id){ contact in
                                cardPersonalContact(contact: contact)
                            }
                        }
                        .padding(.vertical, 12)
                    }
                    .sheet(isPresented: $showContactPicker) {
                        ContactPicker { contact in
                            let name = CNContactFormatter.string(from: contact, style: .fullName) ?? "Unknown"
                            let phone = contact.phoneNumbers.first?.value.stringValue ?? "No number"
                            
                            let newContact = ContactModel(name: name, phone: phone)
                            modelContext.insert(newContact)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                Task {
                    await self.contactManager.requestAccess()
                }
            }
            .navigationTitle("Emergency Contacts")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .dynamicTypeSize(...DynamicTypeSize.accessibility1)

        .searchable(text: $searchText, placement: .toolbar ,prompt: "Search contacts")
        .toolbar {
            if #available(iOS 26, *) {
                DefaultToolbarItem(kind: .search, placement: .topBarTrailing)
            }
            ToolbarItem {
                Button {
                    self.showContactPicker = true
                }label: {
                    Image(systemName: "plus")
                }
            }
        }
        .alert("Delete Contact", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let contact = self.contactToDelete {
                    withAnimation {
                        modelContext.delete(contact)
                    }
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete the contact \(self.contactToDelete?.name ?? "")?")
        }
    }
    
    func cardPersonalContact(contact: ContactModel) -> some View {
        Link(destination: URL(string: "tel://\(contact.number)")!){
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.primary)
                            .frame(width: 24, alignment: .leading)
                        VStack(alignment: .leading) {
                            Text("\(contact.name)")
                                .font(.headline)
                                .foregroundStyle(Color.primary)
                            Text(contact.number)
                                .font(.subheadline)
                                .foregroundStyle(Color(uiColor: .secondaryLabel))
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                }
                Spacer()
                Button {
                    impact.impactOccurred()
                    self.showDeleteAlert = true
                    self.contactToDelete = contact
                }label: {
                    Image(systemName: "trash.fill")
                        .font(.headline)
                        .foregroundStyle(Color("AlertColor2"))
                }
                
                
            }
//            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .padding(20)
            .frame(minHeight: 50)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background{
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                    Rectangle()
                        .foregroundColor(Color(.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .opacity(colorScheme == .dark ? 0.4 : 1)
                }
            }
        }
    }
    
    func cardPrimaryContact(contact: PrimaryContact) -> some View{
        Link(destination: URL(string: "tel://\(contact.number)")!){
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: contact.image ?? "shield.fill")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color("AccentColor2"))
                            .frame(width: 24, alignment: .leading)
                        Text("\(contact.number): \(contact.name)")
                            .font(.headline)
                            .foregroundStyle(Color("AccentColor2"))
                    }
                    Text(contact.description)
                        .font(.caption)
                        .foregroundStyle(Color(uiColor: .secondaryLabel))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                }
                Spacer()
                Image(systemName: "phone.fill")
                    .font(.subheadline)
                    .foregroundStyle(Color("AlertColor2"))
                
                
            }
//            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .padding(16)
            .frame(minHeight: 80)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background{
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                    Rectangle()
                        .foregroundColor(Color(.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .opacity(colorScheme == .dark ? 0.4 : 1)
                }
            }
        }
    }
}

#Preview {
    EmergencyContactsView()
        .preferredColorScheme(.dark)
}
