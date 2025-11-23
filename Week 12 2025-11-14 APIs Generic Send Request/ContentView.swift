//
//  ContentView.swift
//  API Example
//
//  Created by user285344 on 11/14/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var posts = PostViewModel()
    @State private var showCreate = false
    @State private var showEdit = false
    @State private var selectedPost: Post?
    
    var body: some View {
        NavigationView {
            List{
                ForEach(posts.postData){
                    post in
                    HStack{
                        Text("\(post.userId)")
                            .padding()
                            .overlay(Circle().stroke(.blue))
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .bold()
                                .lineLimit(1)
                            
                            Text(post.body)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    } //on tap gesture
                    .onTapGesture {
                        selectedPost = post
                        showEdit = true
                    }
                } //on delete
                .onDelete(perform: deletePost)
            }
            .navigationTitle("Posts")
            .task {
                Task{
                    await posts.fetchData()
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button("Create"){
                            showCreate = true
                        }
                        //more buttons
                        //Button("Create"){
                        //    showCreate = true
                        //}
                    }
                }
            }
            //sheet -> Create view
            .sheet(isPresented: $showCreate){
                CreatePostView{ newPost in
                    Task{
                        await posts.createPost(post: newPost)
                    }
                }
            }
            //sheet -> edit view
            .sheet(item: $selectedPost) {post in
                EditPostView(post: post) { updatedTitle, updatedBody in
                    Task {
                        await posts.editPost(post: post, updatedTitle: updatedTitle, updatedBody: updatedBody)
                    }
                }
            }
        }
    }
    
    private func deletePost(at offsets: IndexSet) {
        for index in offsets {
            let id = posts.postData[index].id
            print("ID: \(id)")
            Task {
                await posts.deletePost(id: id)
            }
        }
    }
}

#Preview {
    ContentView()
}
