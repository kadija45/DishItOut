//
//  AddView.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/18/23.
//

import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseDatabase

@available(iOS 16.0, *)
struct AddView: View {
    @ObservedObject var controller = HomeController()
    @State private var selectedItem: PhotosPickerItem? = nil
    @Binding var selectedImageData: Data?
    @Binding var dish: String
    @Binding var type: String
    @Binding var restaurant: String
    @Binding var mealRat: String
    @Binding var ambRat: String
    @Binding var servRat: String
    @Binding var locRat: String
    @Binding var comments: String
    @State var done = false
    @Environment(\.dismiss) var dismiss
    
    init (selectedImageData : Binding<Data?>, dish : Binding<String>, type : Binding<String>, restaurant : Binding<String>, mealRat : Binding<String>,
          ambRat : Binding<String>, servRat : Binding<String>, locRat : Binding<String>, comments : Binding <String> , controller : HomeController) {
        
        self.controller = controller
        self._selectedImageData = selectedImageData
        self._dish = dish
        self._type = type
        self._restaurant = restaurant
        self._mealRat = mealRat
        self._ambRat = ambRat
        self._servRat = servRat
        self._locRat = locRat
        self._comments = comments
        
    }
    
    
    var body: some View {
      
            ScrollView {
                VStack {
                    Text("Add Listing").font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 34)
                    ).padding(.vertical)
                    Group {
                        HStack {
                            Text("Dish Name:").frame(width:100, height: 10).padding().font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                            TextField("", text:$dish) {}.frame(width: 200, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        }
                        HStack {
                            Text("Restaurant:").frame(width:100, height: 10).padding().font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                            TextField("", text:$restaurant) {}.frame(width: 200, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        }
                        HStack {
                            Text("Meal Type:").frame(width:100, height: 10).padding().font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                            TextField("", text:$type) {}.frame(width: 200, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        // think about adding location somehow
                    } // end of group 1
                    
                    Group {
                        Text("Ratings").frame(width:100, height: 10).padding().font(
                            .custom(
                            "AmericanTypewriter",
                            fixedSize: 15)
                        )
                        HStack {
                            Text("Meal:").frame(width:100, height: 10).font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                            TextField("", text:$mealRat) {}.frame(width: 25, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("/         5").frame(width:100, height: 10).font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                        }.padding(.bottom)
                        HStack {
                            Text("Ambiance:").frame(width:100, height: 10).font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                            TextField("", text:$ambRat) {}.frame(width: 25, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("/         5").frame(width:100, height: 10).font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                        }.padding(.bottom)
                        HStack {
                            Text("Service:").frame(width:100, height: 10).font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                            TextField("", text:$servRat) {}.frame(width: 25, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("/         5").frame(width:100, height: 10).font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                        }.padding(.bottom)
                        HStack {
                            Text("Location:").frame(width:100, height: 10).font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                            TextField("", text:$locRat) {}.frame(width: 25, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle())
                            Text("/         5").frame(width:100, height: 10).font(
                                .custom(
                                "AmericanTypewriter",
                                fixedSize: 15)
                            )
                        }.padding(.bottom)
                        
                    }.padding(.bottom) // end of group 2
                    
                    Group {
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()) {
                                 
                                Text("Select a photo").font(.custom("AmericanTypewriter", fixedSize: 15)).fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(width: 200, height: 50)
                                    .background(Rectangle().fill(Color.white).shadow(radius: 3))
                                
                                
                            }
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    // Retrieve selected asset in the form of Data
                                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                    }
                                }
                            }
                        
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit().aspectRatio(contentMode: .fit)
                        }// end of choose picture stuff

                    }.padding(.bottom)
                    
                    HStack {
                        Text("Comments:").frame(width:100, height: 10).padding().font(
                            .custom(
                            "AmericanTypewriter",
                            fixedSize: 15)
                        )
                        TextEditor(text:$comments).frame(width: 200, height: 75, alignment: .center).foregroundColor(.secondary).border(.gray)
                    }.padding(.bottom)
             
                    Button(action: updateDatabase) { // come back for action
                        Text("Upload").font(.custom("AmericanTypewriter", fixedSize: 15))
                    }.buttonStyle(.bordered).font(.system(size: 15)).frame(width: 200, height: 50)
                  
                    
                } // end of VStack
                
            }// end of scroll view
            
      
        
    } // end of body
    
    func updateDatabase() {
        controller.postPosting()
        selectedImageData = Data.init()
        dish = ""
        type = ""
        restaurant = ""
        mealRat = ""
        ambRat = ""
        servRat = ""
        locRat = ""
        comments = ""
        dismiss()

    }
}// end of struct




