//
//  DescriptionAppView.swift
//  Toxapex
//
//  Created by Marco Bueno on 17/01/26.
//

import SwiftUI


struct DescriptionAppView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Text("DescriptionAppView")
        }
        .toolbar{
            ToolbarItem{
                Button {
                    dismiss()
                }label:{
                    Image(systemName: "xmark")
                }
            }
        }
    }
}
