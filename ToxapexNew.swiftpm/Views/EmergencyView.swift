//
//  EmergencieView.swift
//  Toxapex
//
//  Created by Marco Bueno on 14/01/26.
//

import SwiftUI

struct EmergencyView: View {
    var emergency: Emergency // Recebe o objeto completo
    @State private var currentStepIndex = 0

    var body: some View {
        ZStack {
            // Fundo dinâmico baseado na cor da emergência
            LinearGradient(
                stops: [
                    .init(color: emergency.color.opacity(0.4), location: 0),
                    .init(color: .black, location: 0.6)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // HEADER COM A IMAGEM DA EMERGÊNCIA
                VStack(spacing: 15) {
                    Image(systemName: emergency.image)
                        .font(.system(size: 60))
                        .foregroundStyle(emergency.color)
                        .shadow(color: emergency.color.opacity(0.5), radius: 10)
                    
                    Text(emergency.title)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                }
                .padding(.top, 50)
                .padding(.bottom, 30)

                // LISTA DE PASSOS (STEPPER)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(emergency.steps.enumerated()), id: \.element.id) { index, step in
                            HStack(alignment: .top, spacing: 15) {
                                // Indicador Visual
                                stepIndicator(index: index)

                                // Card do Passo (Suas propriedades: title, stepDescription, image)
                                VStack(alignment: .leading, spacing: 8) {
                                    Label(step.title, systemImage: step.image)
                                        .font(.headline)
                                        .foregroundStyle(index == currentStepIndex ? emergency.color : .primary)
                                    
                                    Text(step.stepDescription)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    // Se houver animação específica, você pode colocar um placeholder aqui
                                    if step.specificAnimation {
                                        capsuleAnimationHint()
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.ultraThinMaterial)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(index == currentStepIndex ? emergency.color.opacity(0.5) : .clear, lineWidth: 1)
                                )
                                .onTapGesture {
                                    withAnimation(.spring()) { currentStepIndex = index }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }

    // Função auxiliar para o número do passo
    @ViewBuilder
    func stepIndicator(index: Int) -> some View {
        VStack {
            Circle()
                .fill(index <= currentStepIndex ? emergency.color : Color.gray.opacity(0.3))
                .frame(width: 28, height: 28)
                .overlay(Text("\(index + 1)").font(.caption2).bold().foregroundStyle(.white))
            
            if index < emergency.steps.count - 1 {
                Rectangle()
                    .fill(index < currentStepIndex ? emergency.color : Color.gray.opacity(0.3))
                    .frame(width: 2, height: 60)
            }
        }
    }
    
    @ViewBuilder
    func capsuleAnimationHint() -> some View {
        Text("ANIMAÇÃO ATIVA")
            .font(.system(size: 8, weight: .bold))
            .padding(4)
            .background(emergency.color.opacity(0.2))
            .cornerRadius(4)
    }
}
