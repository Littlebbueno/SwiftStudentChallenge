//
//  HomeView.swift
//  Toxapex
//
//  Created by Marco Bueno on 29/12/25.
//

import SwiftUI

struct TravelView: View {
    @State var immediateEmergencies: [Emergency]
    @State var roadWeatherEmergencies: [Emergency]
    @State var vehicleEmergencies: [Emergency]
    
    let colorCardEmergencyContacts = Color("AlertColor")
    @State var showDescriptionApp: Bool = false
    @State var selectedEmergency: Emergency?
    
    @Environment(\.colorScheme) var colorScheme
    
    // Search
    @State var searchText: String = ""
    var filteredImmediate: [Emergency] {
        if searchText.isEmpty {
            return immediateEmergencies
        } else {
            return immediateEmergencies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var filteredRoadWeather: [Emergency] {
        if searchText.isEmpty {
            return roadWeatherEmergencies
        } else {
            return roadWeatherEmergencies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var filteredVehicle: [Emergency] {
        if searchText.isEmpty {
            return vehicleEmergencies
        } else {
            return vehicleEmergencies.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    @State private var animateGradient = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack {
                LinearGradient(
                    colors: [Color.orange, Color("FlatTire"), .clear],
                    startPoint: animateGradient ? .topLeading : .topTrailing,
                    endPoint: .bottom
                )
                .onAppear {
                    withAnimation(.linear(duration: 6.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
                .offset(y: -300)
                .opacity(colorScheme == .dark ? 0.6 : 0.6)
                Spacer()
            }
//            Image("imageExample2")
//                .resizable()
//                .containerRelativeFrame(.horizontal) { length, axis in
//                    length * 1
//                }
//                .clipped()
//                .ignoresSafeArea()
//                .opacity(0.27)
                
            ScrollView{
                VStack(alignment: .leading){
                    initialCards
                        .padding(.horizontal)
                    HStack {
                        Text("Immediate Emergencies")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 8)
                    emergencies(items: filteredImmediate )
                    HStack {
                        Text("Vehicle Emergencies")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 8)
                    emergencies(items: filteredVehicle)
                    HStack {
                        Text("Road & Weather Emergencies")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 8)
                    emergencies(items: filteredRoadWeather)
                    
                }
            }
            .searchable(text: self.$searchText ,placement: .automatic , prompt: "Search")
            .navigationTitle("Travel")
//            .toolbar {
//                ToolbarItem(placement: .primaryAction){
//                    Button{
//                        self.showDescriptionApp = true
//                    }label: {
//                        Image(systemName: "info.circle")
//                    }
//                }
//            }
            .sheet(isPresented: $showDescriptionApp) {
                NavigationStack {
                    DescriptionAppView()
                }
            }
        }
        .fullScreenCover(item: $selectedEmergency) { emergencyItem in
            NavigationStack {
                EmergencyView(emergency: emergencyItem)
            }
        }

    }
    
    var initialCards: some View {
        HStack {
            NavigationLink(
                destination: EmergencyContactsView()
            ){
                HStack(alignment: .center, spacing: 10) {
                    // Opções: person.crop.circle.badge.exclamationmark
                    Image(systemName: "person.crop.circle.badge.exclamationmark")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.leading)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Emergency Contacts")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .dynamicTypeSize(...DynamicTypeSize.large)
                        Text("Add your emergency contacts here for quick access.")
                            .font(.system(size: 11))
                            .foregroundStyle(.white)
                            .dynamicTypeSize(...DynamicTypeSize.large)
                    }
                    Spacer()
                    
                }
                .containerRelativeFrame(.vertical) { length, axis in
                    length * 0.15
                }
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.ultraThinMaterial)
                        Rectangle()
                            .cornerRadius(17)
                            .foregroundStyle(colorCardEmergencyContacts.gradient)
                            .opacity(0.8)
                    }
                }
                    
            }
        }
    }
    
    func emergencies(items: [Emergency]) -> some View {
        VStack(spacing: 12) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, emergency in
                Button{
                    selectedEmergency = emergency
                }label: {
                    VStack {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: emergency.image)
                                .frame(width: 18)
                                .foregroundColor(emergency.color)
                            
                            VStack {
                                HStack {
                                    Text(emergency.title)
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundStyle(Color.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundStyle(Color.secondary)
                                }
                                if index < items.count - 1 {
                                    Divider()
                                }
                            }
                            
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background{
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(.ultraThinMaterial)
                Rectangle()
                    .foregroundColor(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(14)
                    .opacity(colorScheme == .dark ? 0.4 : 0.8)
            }
            .padding(.horizontal)

        }
    }
}

