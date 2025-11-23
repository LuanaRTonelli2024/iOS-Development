//
//  PostViewModel.swift
//  API Example
//
//  Created by user285344 on 11/14/25.
//

import Foundation
import Combine //Obserable Object

class PostViewModel: ObservableObject {
    
    // Not using shared [singleton Pattern]
    // This class does not have a SDK // Firebase has an SDK and init code, wich makes the implementation heavy
    // REST: [Client --> Server] / connection is not realtime
    // Firebase: [Client === Server] / conection is realtime
    
    @Published var postData = [Post]() //() --> Initialising an empty list of Posts
    
    //Annotation
    @MainActor //run this method in the main thread
    func fetchData() async {
        guard let posts: [Post] = await WebService().sendRequest(
            fromUrl: "https://jsonplaceholder.typicode.com/posts",
            method: .GET)
        else{
            return
        }
        
        postData = posts //store the [post]
        
    }
    
    //create
    func createPost(post: Post) async {
        if let result: Post = await WebService().sendRequest(
            fromUrl: "https://jsonplaceholder.typicode.com/posts",
            method: .POST,
            body: post) {
            print("created: \(result)")
        }
    }
    
    //update
    func editPost(post: Post, updatedTitle: String, updatedBody: String) async {
        
        let updatedPost = Post(userId: post.userId, id: post.id, title: updatedTitle, body: updatedBody)
        
        if let result: Post = await WebService().sendRequest(
            fromUrl:"https://jsonplaceholder.typicode.com/posts/\(post.id)",
            method: .PUT,
            body: updatedPost) {
            print("Updated: \(result)")
        }
    }
    
    //delete
    func deletePost(id: Int) async {
        let _: Post? = await WebService().sendRequest(
            fromUrl: "https://jsonplaceholder.typicode.com/posts/\(id)",
            method: .DELETE) //deleting the post inthe server
        
        //postData
        await MainActor.run{
            postData.removeAll{ $0.id == id}
        }
    }
        
    
//    func fetchData() async {
//        guard let downloadPosts: [Post] = await WebService().downloadData(fromURL: "https://jsonplaceholder.typicode.com/posts") else {return}
//        postData = downloadPosts //download Posts from the API
//    }
}
