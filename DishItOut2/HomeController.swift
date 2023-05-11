//
//  HomeController.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/21/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase



final class HomeController: ObservableObject {
    
    @Published var posts: [PostModel] = []
    @Published var newDish: String = ""
    @Published var newType: String = ""
    @Published var newRest: String = ""
    @Published var newMealRat: String = ""
    @Published var newAmbRat: String = ""
    @Published var newServRat: String = ""
    @Published var newLocRat: String = ""
    @Published var newComm: String = ""
    @Published var newImg: Data? = Data.init()
    
    
    private lazy var databasePath: DatabaseReference? = {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        let ref = Database.database().reference().child("users/\(uid)/posts")
            return ref
    }()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    

    func listenForThoughts() {
        
        guard let databasePath = databasePath else {
            return
        }
        databasePath.observe(.childAdded) { [weak self] snapshot in
            
            guard let self = self, var json = snapshot.value as? [String: Any] else {
                return
            }

            json["id"] = snapshot.key

            do {
                
                let postData = try JSONSerialization.data(withJSONObject: json)
                let post = try self.decoder.decode(PostModel.self, from: postData)
                var cont = false
                for p in self.posts {
                    if p.id == post.id {
                        cont = true
                    }
                }
                if (cont == false) {
                    self.posts.append(post)
                    print("append")
                }
            
                
            } catch {
                print("error reading", error)
            }
        }
    }

    func stopListening() {
        databasePath?.removeAllObservers()
    }

    func postPosting()  {
        
        guard let databasePath = databasePath else {
           return
        }

        if newDish.isEmpty && newType.isEmpty && newRest.isEmpty && newMealRat.isEmpty && newAmbRat.isEmpty &&
        newServRat.isEmpty && newLocRat.isEmpty && newComm.isEmpty && newImg!.isEmpty {
            
            return 
        }

        let post = PostModel(dish: newDish, type: newType, restaurant: newRest, mealRat: newMealRat, ambRat: newAmbRat, servRat: newServRat, locRat: newLocRat, comments: newComm, picData: newImg)

        do {
            
            let data = try encoder.encode(post)
            let json = try JSONSerialization.jsonObject(with: data)
            databasePath.childByAutoId().setValue(json)
        } catch {
            print("error posting", error)
        }
        
    }
}
