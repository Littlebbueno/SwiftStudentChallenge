//
//  AttentionView.swift
//  Toxapex
//
//  Created by Marco Bueno on 02/02/26.
//
import SwiftUI

struct AttentionView: View {
    @State var editedMode: Bool = false
    // false == Vision, true == ARKit
    @Environment(\.colorScheme) var colorScheme
    
    // false = Vision, true = ARKit
    @AppStorage("assistantModel") var attentionMode: Bool = false
    
    // false = off, true = on
    @AppStorage("acessibilityMode") var acessibilityActivated: Bool = false
    // false = left, true = right
    @AppStorage("acessibilityEye") var acessibilityEye: Bool = false
    
    @State var eyeChoice: Bool = false
    @State var acessibilityChoice: Bool = false
    @State var editing: Bool = false
    @State var showAcessibilitySheet : Bool = false
    
    init() {
        let currentMode = UserDefaults.standard.bool(forKey: "acessibilityMode")
        let currentEye = UserDefaults.standard.bool(forKey: "acessibilityEye")
        
        _acessibilityChoice = State(wrappedValue: currentMode)
        _eyeChoice = State(wrappedValue: currentEye)
    }
    
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
                VStack {
                    Spacer()
                    Text(attentionMode ? "ARKit Mode" : "Vision Mode")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.7))
                        .offset(y: -80)
                }
            }
            
        }
        .toolbar{
            ToolbarItem {
                if self.editing == false {
                    editingButton()
                }
            }
        }
    }
    
    func editingButton() -> some View {
        Button{
            withAnimation {
                self.editing = true
                self.editedMode = self.attentionMode
            }
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
    
    func editingView() -> some View {
        ZStack {
            VStack {
                Spacer()
                ZStack {
                    LinearGradient(
                        stops: [
                            .init(color: .black, location: 0),
                            .init(color: .clear, location: 1)
                        ],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                }
                .containerRelativeFrame(.vertical) { length, axis in
                    length * 0.5
                }
            }
            .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 12) {
                Spacer()
                Button {
                    showAcessibilitySheet = true
                }label:{
                    HStack {
                        Text("Acessibility Mode")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(.vertical)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.white)
                    }
                    .padding(.horizontal)
                }
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.ultraThinMaterial)
                            .opacity(0.3)
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
                    }
                }
                Button{
                    editedMode.toggle()
                }label:{
                    HStack {
                        Text("Change Mode:")
                            .fontWeight(.medium)
                            .padding(.vertical)
                            .foregroundStyle(.white)
                        Text(editedMode ? "ARKit Mode" : "Vision Mode")
                            .fontWeight(.semibold)
                            .foregroundStyle(editedMode ? Color("ARColor") : Color("VisionColor"))
                            .padding(8)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                }
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(.ultraThinMaterial)
                            .opacity(0.3)
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.white.opacity(0.5), lineWidth: 0.5)
                    }
                }
                Button{
                    withAnimation {
                        attentionMode = editedMode
                        self.acessibilityActivated = self.acessibilityChoice
                        self.acessibilityEye = self.eyeChoice
                        editing = false
                    }
                }label:{
                    Text("Save")
                        .padding(5)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 12)
                .tint(.white)
                .buttonStyle(.glassProminent)
            }
            .sheet(isPresented: $showAcessibilitySheet){
                AcessiblitySheetView(acessibilityChoice: self.$acessibilityChoice, eyeChoice: self.$eyeChoice)
                    .presentationDetents([.medium])
            }
            .padding()
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))

        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button{
                    withAnimation {
                        editing = false
                    }
                    self.acessibilityChoice = self.acessibilityActivated
                    self.eyeChoice = self.acessibilityEye
                }label:{
                    Image(systemName: "xmark")
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AttentionView()
            .preferredColorScheme(.dark)
    }
}
