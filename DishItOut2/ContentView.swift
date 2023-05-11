//
//  ContentView.swift
//  DishItOut2
//
//  Created by Kadija Koroma on 4/20/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authModel: AuthenticationModel
    var body: some View {
        Group {
            if (authModel.user == nil) {
                LoginView()
            } else {
                HomeView()
            }
        }.onAppear {
            authModel.listenToAuthState()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthenticationModel())
    }
}
