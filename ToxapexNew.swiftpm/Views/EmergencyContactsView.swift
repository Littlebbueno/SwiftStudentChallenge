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
                            Link(destination: URL(string: "tel://\(contact.number)")!){
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack(spacing: 8) {
                                        Image(systemName: contact.image ?? "shield.fill")
                                            .font(.system(.headline, design: .rounded))
                                            .fontWeight(.bold)
                                            .foregroundStyle(colorScheme == .dark ? Color("Azul"): Color("Azul"))
                                            .frame(width: 24, alignment: .leading)
                                        VStack(alignment: .leading) {
                                            Text("\(contact.number): \(contact.name)")
                                                .font(.headline)
                                                .foregroundStyle(colorScheme == .dark ? Color("Azul"): Color("Azul"))
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
                                }
                                .dynamicTypeSize(...DynamicTypeSize.xLarge)
                                .padding()
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
                    Text("Personal Contacts")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                }
                .padding()
            }
            .navigationTitle("Emergency Contacts")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}
