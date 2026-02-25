import SwiftUI

enum navigationPath: Hashable {
    case medical
    case cpr
    case fire
    case animalHit
    case moveVictim
}

@main
struct MyApp: App {
    @State var emergencyManager = EmergencyManager()
    @AppStorage("initialOnboarding") var initialOnboarding: Bool = false
    var body: some Scene {
        WindowGroup {
            if self.initialOnboarding == false {
                InitialOnboardingView()
            }
            else {
                TabView {
                    NavigationStack {
                        TravelView(immediateEmergencies: emergencyManager.immediateEmergencies, roadWeatherEmergencies: emergencyManager.roadWeatherEmergencies, vehicleEmergencies: emergencyManager.vehicleEmergencies)
                        //                            .preferredColorScheme(ColorScheme.dark)
                    }
                    .tabItem {
                        Label("Emergencies", systemImage: "light.beacon.max.fill")
                    }
                    NavigationStack {
                        AttentionView()
                    }
                    .tabItem {
                        Label("Attention", systemImage: "road.lanes.curved.left")
                    }
                    //                NavigationStack {
                    //                    ResourcesView()
                    //                }
                    //                .tabItem {
                    //                    Label("Resources", systemImage: "book.pages.fill")
                    //                }
                }
            }
        }
        .modelContainer(for: ContactModel.self)
    }
}
