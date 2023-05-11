//
//  LoginView.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/18/23.
//

import SwiftUI
import FirebaseAuth

@available(iOS 16.0, *)
struct LoginView: View {
    @EnvironmentObject private var authModel: AuthenticationModel
    

    @State var email: String = ""
    @State var password: String = ""
    @State var loginMsg = "Log In"
    
    
    @State var signUpMsg = "Sign Up"
    @State var goToHome = false
    @State var signUp = false
  
    @State var errorMsg = ""
    
    var body: some View {
      
            VStack{
                Text("DISH IT OUT").font(
                    .custom(
                    "AmericanTypewriter",
                    fixedSize: 34)
                )
                Image("restaurant").resizable()
                    .scaledToFit().aspectRatio(contentMode: .fit)
                HStack {
                    Text("Email:").frame(width:80, height: 10).padding().font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                    TextField("john.doe@gmail.com", text:$email) {
                        
                    }.textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress).frame(width: 200, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle())

                }
                HStack {
                    Text("Password:").frame(width:80, height: 10).padding().font(
                        .custom(
                        "AmericanTypewriter",
                        fixedSize: 15)
                    )
                    SecureField("password", text:$password) {
                        
                    }.frame(width: 200, height: 20, alignment: .center).textFieldStyle(RoundedBorderTextFieldStyle())

                }
                HStack {
                    Button(action: checkLogin) {
                        Text(loginMsg).font(.custom("AmericanTypewriter", fixedSize: 15))
                    }.buttonStyle(.bordered).font(.system(size: 15)).frame(width: 150, height: 50)
                        

                    Button(action: doSignUp) {
                        Text(signUpMsg).font(.custom("AmericanTypewriter", fixedSize: 15))
                    }.buttonStyle(.bordered).font(.system(size: 15)).frame(width: 150, height: 50)
                        
                }
               
                Text(errorMsg).font(
                    .custom(
                    "AmericanTypewriter",
                    fixedSize: 16)).padding(.vertical)

            }
    }
    func doSignUp() {
//        var result : Bool
        if(email == "" && password == "") {
            errorMsg = "Incorrect inputs. Please try again"
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if(error != nil) {
                    errorMsg = "That account already exists. Please try loggging in"
                } else {
                    goToHome = true
                }
            }

        }
        
        
    }
    func checkLogin() {
        if(email == "" && password == "") {
            errorMsg = "Incorrect inputs. Please try again"
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    errorMsg = "That login is incorrect. Please try again"
                } else {
                    goToHome = true
                }
            }
        
        }
    
    }
}

@available(iOS 16.0, *)
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

