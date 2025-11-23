//
//  EditPostView.swift
//  API Example
//
//  Created by user285344 on 11/22/25.
//

import SwiftUI

struct EditPostView: View {
    
    var post: Post
    @State var title: String
    @State var bodyMessage: String
    
    //             title    body
    var onUpdate: (String, String) -> Void
    
    //prefill tge data with the post details
    init(post: Post, onUpdate: @escaping (String, String) -> Void){
        self.post = post
        //title
        _title = State(initialValue: post.title)
        //body
        _bodyMessage = State(initialValue: post.body)
        self.onUpdate = onUpdate
    }
    
    var body: some View {
        Form{
            Section("Edit Post"){
                Text("Post ID: \(post.id)")
                
                TextField("Title", text: $title)
                TextField("Body", text: $bodyMessage)
                
                Button("Update"){
                    //      String, String
                    onUpdate(title, bodyMessage)
                }.disabled(title.isEmpty || bodyMessage.isEmpty)
            }
        }
    }
}

//#Preview {
//    EditPostView()
//}
