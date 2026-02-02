//
//  HomeView.swift
//  Toxapex
//
//  Created by Marco Bueno on 29/12/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct TravelView: View {
    @State var immediateEmergencies: [Emergency]

    @State var roadWeatherEmergencies: [Emergency]

    @State var vehicleEmergencies: [Emergency]
    
    let colorCardEmergencyContacts = Color("AlertColor")
    
    @State var showDescriptionApp: Bool = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            //MARK: CORRIGIR PARA TIRAR OFFSET
//            LinearGradient(
//                gradient: Gradient(colors: [.accentColor, .clear]),
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            .opacity(0.7)
//            .offset(y: -300)
            Image("imageExample2")
                .resizable()
                .containerRelativeFrame(.horizontal) { length, axis in
                    length * 1
                }
                .clipped()
                .ignoresSafeArea()
                .opacity(0.27)
                
            ScrollView{
                VStack(alignment: .leading){
                    initialCards
                        .padding(.horizontal)
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(Color.red)
                        Text("Immediate Emergencies")
                            .font(.headline)
                            .foregroundStyle(Color.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 8)
                    emergencies(items: self.listExamplesHighways)
                    HStack {
                        Image(systemName: "car.side.front.open.fill")
                            .foregroundStyle(Color.indigo)
                        Text("Vehicle Emergencies")
                            .font(.headline)
                            .foregroundStyle(Color.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 8)
                    emergencies(items: self.listExamplesCarFailures)
                    HStack {
                        Image(systemName: "cloud.rain.fill")
                            .foregroundStyle(Color.blue)
                        Text("Road & Weather Emergencies")
                            .font(.headline)
                            .foregroundStyle(Color.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 8)
                    emergencies(items: self.listExamplesCarFailures)
                    
                }
            }
            .searchable(text: .constant(""),placement: .automatic , prompt: "Search")
            .navigationTitle("Travel")
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button{
                        self.showDescriptionApp = true
                    }label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $showDescriptionApp) {
                NavigationStack {
                    DescriptionAppView()
                }
            }
        }
    }
    
    var initialCards: some View {
        HStack {
            NavigationLink(
                destination: EmergencyContactsView()
            ){
                ZStack {
                    Rectangle()
                        .containerRelativeFrame(.horizontal) { length, axis in
                            length * 0.45
                        }
                        .cornerRadius(20)
                        .foregroundStyle(colorCardEmergencyContacts.gradient)
                    VStack(alignment: .leading, spacing: 10) {
                        // Opções: person.crop.circle.badge.exclamationmark
                        Image(systemName: "phone.fill")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Emergency Contacts")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .dynamicTypeSize(...DynamicTypeSize.large)
                        
                    }
                    .padding(8)
                    .padding(.horizontal, 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    
                }
            }
            NavigationLink(
                destination: ItemsTravelView()
            ){
                ZStack {
                    Rectangle()
                        .containerRelativeFrame(.horizontal) { length, axis in
                            length * 0.45
                        }
                        .cornerRadius(20)
                        .foregroundStyle(colorCardItems.gradient)
                    VStack(alignment: .leading, spacing: 10) {
                        // Opções: suitcase.rolling.fill, backpack.fill
                        Image(systemName: "suitcase.fill")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Items to next travel")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .dynamicTypeSize(...DynamicTypeSize.large)
                            
                    }
                    .padding(8)
                    .padding(.horizontal, 4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                }
            }
        }
        .containerRelativeFrame(.vertical) { length, axis in
            length * 0.20
        }
    }
    
    func emergencies(items: [Emergency]) -> some View {
        VStack(spacing: 15) {
            ForEach(items, id: \.self) { emergency in
                NavigationLink(destination: EmergencyView(emergency: emergency)){
                    HStack {
                        Image(systemName: "arrow.2.circlepath")
                            .foregroundColor(Color.secondary)
                        Text("\(example)")
                            .font(.headline)
                            .foregroundStyle(Color.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.secondary)
                        
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background{
            Rectangle()
                .foregroundColor(Color(.secondarySystemGroupedBackground))
                .cornerRadius(14)
                .padding(.horizontal)
        }
    }
}

