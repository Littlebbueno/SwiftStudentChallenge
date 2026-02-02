//
//  ItemsTravel.swift
//  Toxapex
//
//  Created by Marco Bueno on 16/01/26.
//

import SwiftUI



struct ItemsTravelView: View {
    @State var items: [Item] = [Item(title: "Blue backpack"), Item(title: "MacBook")]
    
    let colorCardItems = Color.brown.blend(with: Color.white, ratio: 0.2) ?? .gray
    
    var body: some View {
        ScrollView(){
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Items")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(colorCardItems)
                    ForEach(items, id: \.self.title) { item in
                        HStack {
                            ZStack {
                                Circle()
                                    .stroke(colorCardItems, lineWidth: 1)
                                    .frame(width: 20, height: 20)
                                    
                                Circle()
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(colorCardItems)
                            }
                            Text(item.title)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .toolbar{
            ToolbarItem{
                Button{
                    
                }label:{
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
