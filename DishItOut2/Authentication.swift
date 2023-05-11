//
//  Authentication.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/19/23.
//

import SwiftUI
import FirebaseAuth

final class AuthenticationModel: ObservableObject {
  var user: User? {
    didSet {
      objectWillChange.send()
    }
  }

  func listenToAuthState() {
    Auth.auth().addStateDidChangeListener { [weak self] _, user in
      guard let self = self else {
        return
      }
      self.user = user
    }
  }

  func signUp(emailAddress: String, password: String) -> Bool {
      
      var failed = false
      Auth.auth().createUser(withEmail: emailAddress, password: password) { (authResult, error) in
          if(error != nil) {
              failed = true
          }
      }
      return failed
  }

  func signIn(emailAddress: String, password: String) -> Bool {
      var failed = false
      Auth.auth().signIn(withEmail: emailAddress, password: password) { (authResult, error) in
          if error != nil {
              failed = true
          }
      }
    return failed
  }

  func signOut() -> Bool {
      
      var failed = false
      if Auth.auth().currentUser != nil {
          do {
              try Auth.auth().signOut()
          } catch {
              failed = true
          }
      }
      return failed
   
  }
    
    
}
