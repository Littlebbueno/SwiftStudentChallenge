//
//  AttentionView.swift
//  Toxapex
//
//  Created by Marco Bueno on 02/02/26.
//
import SwiftUI

struct AttentionView: View {
    @State var attentionMode: Bool = false
    // false == Vision, true == ARKit
    @Environment(\.colorScheme) var colorScheme
    
    @State var editing: Bool = false

    
    var body: some View {
        ZStack {
            Image("imageExample2")
                .resizable()
                .containerRelativeFrame(.horizontal) { length, axis in
                    length * 1
                }
                .clipped()
                .ignoresSafeArea()
                .opacity(colorScheme == .dark ? 0.8 : 1)
            LinearGradient(
                stops: [
                    .init(color: .black, location: 0),
                    .init(color: .clear, location: 0.4)
                ],
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
            if editing {
                editingView()
            }
            else{
                if attentionMode {
                    AttentionARKitView()
                }else{
                    AttentionVisionView()
                }
            }
        }
        .toolbar{
            ToolbarItem {
                if self.editing == false {
                    Button{
                        self.editing = true
                    }label:{
                        HStack(spacing: 4) {
                            Image(systemName: "pencil")
                                .font(.caption)
                            Text("Editar")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }
                }
            }
        }
    }
    
    func editingView() -> some View {
        VStack(spacing: 12) {
            Spacer()
            Text(attentionMode ? "ARKit Mode" : "Vision Mode")
                .fontWeight(.semibold)
                .foregroundStyle(.indigo)
            Button{
                attentionMode.toggle()
            }label:{
                HStack {
                    Text("Change Mode")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .glassEffect(in: .rect(cornerRadius: 12.0))
                }
            }
            Button{
                withAnimation {
                    editing = false
                }
            }label:{
                Text("Save Changes")
                    .padding(5)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
            }
            .tint(.white)
            .buttonStyle(.glassProminent)
            Button{
                withAnimation {
                    attentionMode.toggle()
                    editing = false
                }
            }label:{
                Text("Cancel")
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            }
            
        }
        .padding()
    }
}
