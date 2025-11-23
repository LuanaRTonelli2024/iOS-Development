//
//  CreatePostView.swift
//  API Example
//
//  Created by user285344 on 11/22/25.
//

import SwiftUI

struct CreatePostView: View {
    
    @State private var userId = ""
    @State private var title = ""
    @State private var bodyMessage = ""
    
    
    //function to save --> function name
    //function body will be defined in the contentview
    
    
    var onSave: (Post) -> Void //return type is nil

    
    var body: some View {
        Form {
            Section("Create a Post"){
                TextField("User Id", text: $userId)
                    .keyboardType(.numberPad)
                
                TextField("Title", text: $title)
                
                TextField("Body", text: $bodyMessage)
                
                Button("Save") {
                    if let uid = Int(userId) {
                        let post = Post(userId: uid, id: uid+1, title: title, body: bodyMessage)
                        
                        onSave(post) //function body will be written in the ContentView
                    }
                }.disabled(userId.isEmpty || title.isEmpty || bodyMessage.isEmpty)
                
            }
        }
    }
}

//#Preview {
//    CreatePostView()
//}
