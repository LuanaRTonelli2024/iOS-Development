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
    
    func fetchData() async {
        guard let downloadPosts: [Post] = await WebService().downloadData(fromURL: "https://jsonplaceholder.typicode.com/posts") else {return}
        postData = downloadPosts //download Posts from the API
    }
}
