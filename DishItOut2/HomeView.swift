//
//  HomeView.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/18/23.
//

import SwiftUI
import Foundation

@available(iOS 16.0, *)
struct HomeView: View {
    @State var add = false
    @State var logout = false
    @State var errorMsg = ""
    @State var food =  ""
    @State var food2 = ""
    @State var recipes = [RecipeModel()]
    @State var show = false
    

    @StateObject var modController = HomeController()
    @Environment(\.defaultMinListRowHeight) var minRowHeight
  
    
    
    @EnvironmentObject private var authModel: AuthenticationModel
    
    
    var body: some View {
            TabView {
                NavigationView {
                    VStack {
                        ZStack {
                            ScrollView {
                                List(modController.posts) { post in
                                    PostView(img: post.picData, dish: post.dish, type: post.type, restaurant: post.restaurant, mealRat: post.mealRat, ambRat: post.ambRat, servRat: post.servRat, locRat: post.locRat, comments: post.comments)
                                }.frame(minHeight: minRowHeight * 15)
                            }
                        }.onAppear {
                            modController.listenForThoughts()
                        }.onDisappear {
                            modController.stopListening()
                        }.navigationViewStyle(StackNavigationViewStyle())
                            
                    
                        Button(action: {
                            add = true
                        }) {
                            Text("+").font(.custom("AmericanTypewriter", fixedSize: 50))
                        }.buttonStyle(.bordered).font(.system(size: 15)).frame(width: 150, height: 50).clipShape(Circle()).fullScreenCover(isPresented: $add) {
                            AddView(selectedImageData: $modController.newImg, dish: $modController.newDish, type: $modController.newType, restaurant: $modController.newRest, mealRat: $modController.newMealRat, ambRat: $modController.newAmbRat, servRat: $modController.newServRat, locRat: $modController.newLocRat, comments: $modController.newComm, controller: modController)
                        }
                    }.navigationTitle("Dish It Out").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true).toolbar {
                        signOutButton()
                      }
                    
                }.tabItem {Text("Home")}

                VStack {
                    Text("Enter food").frame(width:200, height: 10).padding().padding(.bottom).font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                    TextField("", text:$food) {}.frame(width: 200, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle()).padding().padding(.bottom)
                            
                    Button(action: search) {
                        Text("Search").font(.custom("AmericanTypewriter", fixedSize: 15))
                    }.buttonStyle(.bordered).font(.system(size: 15)).frame(width: 150, height: 50)
                        .sheet(isPresented: $show) {
                            NavigationView {
                                ScrollView {
                                    List {
                                        ForEach(recipes, id: \.id) { r in
                                            
                                            VStack {
                                                Text(r.title ?? "Error").fixedSize(horizontal: false, vertical: true).allowsTightening(true).padding().padding(.bottom).font(
                                                    .custom(
                                                    "AmericanTypewriter",
                                                    fixedSize: 15)
                                                )
                                                Text(r.servings ?? "Error").fixedSize(horizontal: false, vertical: true).allowsTightening(true).padding().padding(.bottom).font(
                                                    .custom(
                                                    "AmericanTypewriter",
                                                    fixedSize: 15)
                                                )
                                                Text(r.ingredients ?? "Error").fixedSize(horizontal: false, vertical: true).allowsTightening(true).padding().padding(.bottom).font(
                                                    .custom(
                                                    "AmericanTypewriter",
                                                    fixedSize: 15)
                                                )
                                                Text(r.instructions ?? "Error").fixedSize(horizontal: false, vertical: true).allowsTightening(true).padding().padding(.bottom).font(
                                                    .custom(
                                                    "AmericanTypewriter",
                                                    fixedSize: 15)
                                                )
                                            }.frame(maxWidth: .infinity, minHeight: 150).padding(.horizontal).background(RoundedRectangle(cornerRadius: 50, style: .continuous).fill(Color.blue))
                                        }
                                    }.frame(minHeight: minRowHeight * 18)
                                }.navigationTitle("Recipes for \(food2)").navigationBarTitleDisplayMode(.inline)
                                
                            }
                            
                        }
                    Text(errorMsg).frame(width:300, height: 10).padding().padding(.bottom).font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                }.tabItem {Text("For You")} // for you tab
                
                
//                Button(action: doLogout) {
//                    Text("Logout").font(.custom("AmericanTypewriter", fixedSize: 15))
//                }.buttonStyle(.bordered).font(.system(size: 15)).frame(width: 150, height: 50).tabItem {Text("Settings")}
                    
            }
    }
    @ViewBuilder
    private func signOutButton() -> some View {
      Button(
        action: {
          doLogout()
        },
        label: {
          Text("Sign Out")
            .bold()
            .font(.custom("AmericanTypewriter", fixedSize: 10))
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(
              Capsule()
                
            )
        }
      )
    }
    
    func doLogout() {
        var result : Bool
        result = authModel.signOut()
        if(result != true) {
            logout = true
        }
    }
    func search() {
        if (food != "") {
            let query = "\(food)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/recipe?query="+query!)!
            var request = URLRequest(url: url)
            request.setValue("H29cXYqzm2j6Lx1d791pUA==jz67UXh53MhI3Mtm", forHTTPHeaderField: "X-Api-Key")
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                guard let data = data else {
                    
                    errorMsg = "There was an error with your request. Please try again"
                    return
                    
                }
                recipes = try! JSONDecoder().decode([RecipeModel].self, from: data)
                let size = recipes.count - 1
                for i in 0...size {
                    recipes[i].id = i
                //    recipes[i].instructions = recipes[i].instructions?.replacingOccurrences(of: ".", with: ".\("\n")")
                 //   print(recipes[i].instructions!)
                }
                show = true
                food2 = food
                food = ""
            }
            task.resume()
        } else {
            errorMsg = "please enter a food"
        }
        
    }
}

@available(iOS 16.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

