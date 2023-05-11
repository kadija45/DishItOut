//
//  RecpModel.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/23/23.
//

import Foundation

struct RecipeModel : Codable, Identifiable, Hashable {
    
    var id : Int?
    var title : String?
    var ingredients : String?
    var servings : String?
    var instructions : String?
    
}
