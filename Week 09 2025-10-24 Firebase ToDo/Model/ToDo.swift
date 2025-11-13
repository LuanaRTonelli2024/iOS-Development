//
//  ToDo.swift
//  Firebase ToDo App
//
//  Created by user285344 on 11/7/25.
//

import Foundation
import FirebaseFirestore

struct ToDo: Identifiable, Codable {
    @DocumentID var id: String? //firestone will give the id when we upload the id when we upload it to the server
    var title: String
    var isDone: Bool
}

// codable ---> encode and decode your data
// firebase ----> ToDo (Stream of data) --> convert it to a ToDo Model
// App --> Firebase --> ToDo Model ---> Stream of data
// Codable to handle this automatically
