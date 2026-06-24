//
//  CircleAlertView.swift
//  RoadHelper
//
//  Created by Marco Bueno on 26/02/26.
//

import SwiftUI

struct circleAlert: View {
    let number: String
    var body: some View {
        Circle()
            .foregroundStyle(Color("AlertColor2"))
            .frame(width: 50, height: 50)
            .overlay {
                Text(number)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
    }
}
