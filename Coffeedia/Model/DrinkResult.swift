//
//  DrinkResult.swift
//  Coffeedia
//
//  Created by Delvina J on 09/03/26.
//

import SwiftUI

struct DrinkResult: Identifiable {
    var id = UUID()
    let name: String
    let image: String
    let ratio: String
    let description: String
    let  requiredIngredients: [String]
    
    static func getDrinkResult() -> [DrinkResult] {
        return [
            DrinkResult(name: "Caffè Latte",
                        image: "cup.and.saucer.fill",
                        ratio: "1/3 Espresso, 2/3 Milk",
                        description: "A smooth, creamy coffee drink made with espresso and steamed milk.",
                        requiredIngredients: ["Espresso", "Milk"]),
            
            DrinkResult(name: "Cappuccino",
                        image: "cup.and.saucer.fill",
                        ratio: "1/3 Espresso, 1/3 Steamed Milk, 1/3 Foam",
                        description: "A balanced Italian classic with equal parts espresso, steamed milk, and milk foam.",
                        requiredIngredients: ["Espresso", "Milk", "Whipped Cream"]),
            
            DrinkResult(name: "Mocha",
                        image: "leaf.fill",
                        ratio: "Espresso, Chocolate, Milk, Whipped Cream",
                        description: "A sweet blend of espresso, chocolate syrup, steamed milk, and whipped cream.",
                        requiredIngredients: ["Espresso", "Milk", "Chocolate", "Whipped Cream"]),
            
            DrinkResult(name: "Affogato",
                        image: "snowflake",
                        ratio: "Espresso poured over Ice Cream",
                        description: "A delightful dessert drink where hot espresso is poured over cold vanilla ice cream.",
                        requiredIngredients: ["Espresso", "Ice Cream"]),
            
            DrinkResult(name: "Irish Coffee",
                        image: "wineglass.fill",
                        ratio: "Coffee, Sugar, Rum, Cream",
                        description: "A warming cocktail combining hot coffee, rum, sugar, and cream.",
                        requiredIngredients: ["Coffee", "Sugar", "Rum", "Whipped Cream"]),
            
            DrinkResult(name: "Iced Mocha",
                        image: "snowflake",
                        ratio: "Espresso, Milk, Chocolate, Ice",
                        description: "A refreshing iced drink blending espresso, milk, chocolate syrup, and ice.",
                        requiredIngredients: ["Espresso", "Milk", "Chocolate", "Ice"]),
            
            DrinkResult(name: "Espresso Martini",
                        image: "wineglass.fill",
                        ratio: "Espresso, Coffee Liqueur, Vodka",
                        description: "A sophisticated cocktail mixing espresso, coffee liqueur, and vodka.",
                        requiredIngredients: ["Espresso", "Rum", "Sugar"])
        ]
    }
}
