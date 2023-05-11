//
//  ReccView.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/23/23.
//

import SwiftUI

struct ReccView: View {
    @Binding var food : String
    @State var recipes = [RecipeModel()]
    
    
    init (food : Binding<String>) {
        self._food = food

    }
    var body: some View {
        
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


