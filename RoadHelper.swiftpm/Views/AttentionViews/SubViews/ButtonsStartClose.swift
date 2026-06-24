//
//  ButtonsStartClose.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI

struct ButtonStart: View {
    
    let action: () -> Void
    
    var body: some View {
        Button{
            self.action()
        }label:{
            HStack {
                Image(systemName:"play.fill")
                    .foregroundStyle(.black)
                Text("Start Assistant")
                    .padding(8)
                    .foregroundStyle(Color.black)
                    .fontWeight(.semibold)
            }
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .frame(maxWidth: .infinity)

        }
        .tint(Color.white)
        .clipShape(.capsule)
        .modifier(
            ConditionalButtonModifierProminent()
        )
    }
}

struct ButtonClose: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        }label:{
            HStack {
                Image(systemName: "square.fill")
                Text("Close Assistant")
                    .font(.headline)
            }
            .dynamicTypeSize(...DynamicTypeSize.xLarge)
            .foregroundColor(Color("AlertColor"))
            .frame(maxWidth: .infinity)

        }
    }
}
