//
//  HomeView.swift
//  Firebase Example
//
//  Created by user285344 on 11/7/25.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        VStack{
            Text("Welcome \(authManager.user?.email ?? "User")")
                .font(.title)
                .padding()
            
            Button {
                authManager.logout()
            }
            label: {
                Text("Logout")
                    .foregroundStyle(.white)
                    .background(.red)
                    .padding()
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
