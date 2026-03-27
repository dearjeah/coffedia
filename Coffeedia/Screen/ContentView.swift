//
//  ContentView.swift
//  Coffeedia
//
//  Created by Delvina J on 19/02/26.
//

import SwiftUI
import FoundationModels


struct CoffeeBuilderView: View {
    @State private var ingredients: [String] = []
    @State private var showAlert = false
    @State private var showResult = false
    @State private var showAppleIntelligenceAlert = false
    @State private var selectedResult: DrinkResult? = nil
    
    let options: [(name: String, symbol: String)] = [
        ("Espresso", "cup.and.saucer.fill"),
        ("Coffee", "mug.fill"),
        ("Milk", "drop.fill"),
        ("Sugar", "cube.fill"),
        ("Whipped Cream", "cloud.fill"),
        ("Chocolate", "leaf.fill"),
        ("Rum", "wineglass.fill"),
        ("Ice", "snowflake"),
        ("Ice Cream", "birthday.cake.fill")
    ]
    
    // Drinks library with required ingredients
    let drinksLibrary: [DrinkResult] = DrinkResult.getDrinkResult()
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(gradient: Gradient(colors: [Color("Latte"), Color("Caramel")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                // Top container
                VStack {
                    Text(ingredients.isEmpty ? "Choose your ingredients" :
                            ingredients.joined(separator: " + "))
                    .font(.title2.bold())
                    .foregroundColor(Color("CreamText"))
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 180)
                    .background(Color("CoffeeBrown"))
                    .cornerRadius(16)
                    .shadow(radius: 8)
                    .padding()
                }
                
                Spacer()
                
                // Ingredient buttons
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 20) {
                    ForEach(options, id: \.name) { option in
                        IngredientButton(name: option.name, symbol: option.symbol) {
                            if ingredients.count < 5 {
                                ingredients.append(option.name)
                            } else {
                                showAlert = true
                            }
                        }
                    }
                }
                .padding()
                
                // Get Result button
                if !ingredients.isEmpty {
                    HStack() {
                        ActionButton(title: "Clear", backgroundColor: .red) {
                            ingredients.removeAll()
                            selectedResult = nil
                        }
                        
                        ActionButton(title: "Get Result", backgroundColor: Color("CoffeeBrown")) {
                            switch SystemLanguageModel.default.availability {
                            case .unavailable(.appleIntelligenceNotEnabled):
                                showAppleIntelligenceAlert.toggle()
                            case .available:
                                Task { await callFoundationModel()}
                            default:
                                if let match = drinksLibrary.first(where: { Set($0.requiredIngredients) == Set(ingredients) }) {
                                    selectedResult = match
                                } else {
                                    selectedResult = DrinkResult(
                                        name: "Your Custom Creation",
                                        image: "mug.fill",
                                        ratio: ingredients.joined(separator: " + "),
                                        description: "A unique blend of your chosen ingredients. Experiment and enjoy your personalized drink!",
                                        requiredIngredients: ingredients
                                    )
                                }
                            }
                            
                        }
                    }
                    
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Limit Reached"),
                      message: Text("You can only choose up to 5 ingredients."),
                      dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showAppleIntelligenceAlert) {
                Alert(
                    title: Text("Apple Intelligence is not enabled"),
                    message: Text("Please enable your Apple Intelligence in System Settings"),
                    dismissButton: .default(Text("Got it!"))
                )
            }
            .sheet(item: $selectedResult) { result in
                VStack(spacing: 20) {
                    Spacer()
                    Text(result.name)
                        .font(.title.bold())
                        .foregroundColor(Color("CoffeeBrown"))
                    
                    Text(result.image)
                        .font(.largeTitle)
                    
                    Text("Ratio: \(result.ratio)")
                        .font(.subheadline)
                        .foregroundColor(Color("CoffeeBrown"))
                    
                    Text(result.description)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(Color("CoffeeBrown"))
                    
                    Spacer()
                    
                    ActionButton(title: "Close", backgroundColor: Color("CoffeeBrown")) {
                        selectedResult = nil
                    }
                }
            }
        }
    }
    
    func callFoundationModel() async {
        let session = LanguageModelSession(instructions: """
            You are a coffee experts who is very knowledgable in coffee and brewing. Your job is to help the person to find a perfect name of coffee, coffee ratio, and explain why it's called the name of coffee according to added ingredients.
            Make the description as easy to understand for beginner.
            """)
        let addedIngredients = Set(ingredients)
        do {
            let response = try await session.respond(
                to: "Create a coffee from \(addedIngredients)",
                generating: DrinkResult.self
            )
            print(response.content)
            selectedResult = response.content
        } catch {
            print(error)
        }
    }
}

#Preview {
    CoffeeBuilderView()
        .preferredColorScheme(.light)
}
