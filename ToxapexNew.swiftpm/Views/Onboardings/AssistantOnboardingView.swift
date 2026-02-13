//
//  AssistantOnboardingView.swift
//  Toxapex
//
//  Created by Marco Bueno on 12/02/26.
//

import SwiftUI

struct AssistantOnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("imageAssistant")
                    .resizable()
                    .scaledToFill()
                    .containerRelativeFrame(.vertical) { length, axis in
                        length * 0.35
                    }
                    .clipped()
                    .padding(.vertical)
                Text("Texto Explicativo")
                Spacer()
                
            }
            .navigationTitle("Attention Assistant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button{
                        dismiss()
                    }label:{
                        Image(systemName: "xmark")
                    }
                }
            }
            .onDisappear {
                UserDefaults.standard.set(false, forKey: "firstOnboarding")
            }
            
        }
    }
}

#Preview {
    AssistantOnboardingView()
}
