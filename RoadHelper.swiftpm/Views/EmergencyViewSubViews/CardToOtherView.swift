//
//  CardToOtherView.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI


struct CardToOtherView : View {
    var linkTo: navigationPath
    @Binding var path: [navigationPath]
    
    var body: some View {
        Button{
            self.path.append(linkTo)
        }label: {
            if linkTo == navigationPath.cpr {
                HStack {
                    Text("CPR Resuscitation")
                        .padding()
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color("CPREmergency3"))
                .foregroundStyle(.black)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
            }
            if linkTo == navigationPath.fire {
                HStack {
                    Text("Vehicle Fire")
                        .padding()
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color("VehicleFire3"))
                .foregroundStyle(.black)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
            }
            if linkTo == navigationPath.moveVictim {
                HStack {
                    Text("Safely Moving a Victim")
                        .padding()
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color.blue)
                .foregroundStyle(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
            }
        }
    }
}
