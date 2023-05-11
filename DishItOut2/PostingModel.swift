//
//  PostingModel.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/20/23.
//

import Foundation
import PhotosUI

struct PostModel: Identifiable, Codable {
    var id: String?
    var dish: String = ""
    var type: String = ""
    var restaurant: String = ""
    var mealRat: String = ""
    var ambRat: String = ""
    var servRat: String = ""
    var locRat: String = ""
    var comments: String = ""
    var picData: Data?
    
}
