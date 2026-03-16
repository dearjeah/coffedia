//
//  ButtonComponent.swift
//  Coffeedia
//
//  Created by Delvina J on 09/03/26.
//

import SwiftUI

struct IngredientButton: View {
    let name: String
    let symbol: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: symbol)
                    .font(.system(size: 30))
                    .foregroundColor(Color("CoffeeBrown"))
                Text(name)
                    .font(.caption)
                    .foregroundColor(Color("CoffeeBrown"))
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(Color("CreamText"))
            .cornerRadius(12)
            .shadow(radius: 4)
        }
    }
}

struct ActionButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(12)
                .shadow(radius: 6)
        }
        .padding(.horizontal)
    }
}
