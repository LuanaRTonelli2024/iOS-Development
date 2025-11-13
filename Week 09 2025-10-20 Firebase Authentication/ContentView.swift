//
//  ContentView.swift
//  Firebase Example
//
//  Created by user285344 on 11/7/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        NavigationView {
            if authManager.user != nil {
                HomeView()
            }
            else {
                RegisterView()
            }
        }
    }
}

#Preview {
    ContentView()
}
