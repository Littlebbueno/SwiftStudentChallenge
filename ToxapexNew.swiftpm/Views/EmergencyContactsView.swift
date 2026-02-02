//
//  EmergencyContactsView.swift
//  Toxapex
//
//  Created by Marco Bueno on 16/01/26.
//
import SwiftUI

@available(iOS 17.0, *)
struct EmergencyContactsView: View {
    
    let colorCardEmergencyContacts = Color.red.blend(with: Color.white, ratio: 0.25) ?? .gray
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Emergency Contacts")
                            .foregroundStyle(colorCardEmergencyContacts)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
