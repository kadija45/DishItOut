//
//  PostView.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/21/23.
//

import SwiftUI

struct PostView: View {
    let img : Data?
    let dish : String
    let type: String
    let restaurant: String
    let mealRat: String
    let ambRat: String
    let servRat: String
    let locRat: String
    let comments: String
    
    var body: some View {
        Group {
            VStack {
                if let uiImage = UIImage(data: img!) {
                    Image(uiImage: uiImage)
                     .resizable()
                     .scaledToFit()
                     .aspectRatio(contentMode: .fit).padding(.top).padding(.bottom)
                }
                HStack {
                    Text(dish).font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                    Text("from").font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                    Text(restaurant).font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                }.padding(.bottom)
                
            
                Text("Type of Food: " + type).padding(.bottom).font(
                    .custom(
                    "AmericanTypewriter",
                    fixedSize: 15)
                )
                Text("Ratings: ").padding(.bottom).font(
                    .custom(
                    "AmericanTypewriter",
                    fixedSize: 15)
                )
                HStack {
                    Text("Meal: " + mealRat + " / 5").font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                    Text("Ambiance: " + ambRat + " / 5").font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                }.padding(.bottom)
                
                HStack {
                    Text("Service: " + servRat + " / 5").font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                    Text("Location: " + locRat + " / 5").font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                }.padding(.bottom)
                Text("Comments: ").padding(.bottom).font(
                    .custom(
                    "AmericanTypewriter",
                    fixedSize: 15)
                )
                Text(comments).padding(.bottom).font(
                    .custom(
                    "AmericanTypewriter",
                    fixedSize: 15)
                )
                
                

                
            }

            
        }.frame(maxWidth: .infinity, minHeight: 150).padding(.horizontal).background(RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color.blue))
        

    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(img: Data.init(), dish: "Sphaghetti", type: "Italian", restaurant: "Olive Garden", mealRat: "4", ambRat: "3", servRat: "3", locRat: "3", comments: "Not that authentic")
    }
}
