//
//  EmergencyContactsView.swift
//  Toxapex
//
//  Created by Marco Bueno on 16/01/26.
//
import SwiftUI

class PrimaryContact: Identifiable {
    var id: String
    var name: String
    var number: String
    var description: String
    var image: String?
    
    init(name: String, number: String, description: String, image: String?) {
        self.id = name
        self.name = name
        self.number = number
        self.description = description
        self.image = image ?? nil
    }
}
struct EmergencyContactsView: View {
    
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
        ),
        PrimaryContact(
            name: "State Highway Patrol",
            number: "198",
            description: "State-managed highway accidents and crimes.",
            image: "light.beacon.max.fill"
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
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(primaryContacts, id: \.id) { contact in
                            cardPrimaryContact(contact: contact)
                        }
                    }
                    Text("Personal Contacts")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    Text("SAVE THE 0800 NUMBER FOR THE HIGHWAYS YOU USUALLY TRAVEL ON")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
            .navigationTitle("Emergency Contacts")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    func cardPrimaryContact(contact: PrimaryContact) -> some View{
        Link(destination: URL(string: "tel://\(contact.number)")!){
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: contact.image ?? "shield.fill")
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(colorScheme == .dark ? Color("Azul"): Color("Azul"))
                            .frame(width: 24, alignment: .leading)
                        Text("\(contact.number): \(contact.name)")
                            .font(.headline)
                            .foregroundStyle(colorScheme == .dark ? Color("Azul"): Color("Azul"))
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
                    .foregroundStyle(.pink)
                
                
            }
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .padding(16)
//                                .padding(.vertical, 4)
//                                .padding(.trailing, 4)
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
