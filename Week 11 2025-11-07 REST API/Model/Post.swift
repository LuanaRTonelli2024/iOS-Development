//
//  Post.swift
//  API Example
//
//  Created by user285344 on 11/14/25.
//

import Foundation

struct Post: Identifiable, Codable {
    //userId and ID to be fixed
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


//{
//    "userId": 1,
//    "id": 1,
//    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
//},
