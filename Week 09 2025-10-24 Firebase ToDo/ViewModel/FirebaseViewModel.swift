//
//  FirebaseViewModel.swift
//  Firebase ToDo App
//
//  Created by user285344 on 11/7/25.
//

import Foundation
import Combine //Obserable Pattern
import FirebaseFirestore

class FirebaseViewModel: ObservableObject {
    
    //static reference
    static let shared = FirebaseViewModel()
    
    private let db = Firestore.firestore() //the database reference
    
    @Published var toDos: [ToDo] = [] //empty list
    
    
    init(){
        fetchToDos()
    }
    
    func fetchToDos() {
        //callback method
        db.collection("toDos").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            //to convert the stream of data to the ToDo Model
            self.toDos = querySnapshot?.documents.compactMap({ document in
                try? document.data(as: ToDo.self)
            }) ?? []
        }
    }
    
    //add a ToDo
    func addToDo(title: String){
        let newToDo = ToDo(title: title, isDone: false) //by default false
        
        do{
            try db.collection("toDos").addDocument(from: newToDo)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //uptade the status ---> ID of the ToDo, access the ToDo, update the status
    func updateToDoStatus(toDo: ToDo, isDone: Bool){
        guard let todoId = toDo.id else { return }
        
        db.collection("toDos").document(todoId).updateData(["isDone": isDone])
        
    }
    
    //delete the toDo ---> Od of the ToDo, access the ToFo, delete the ToDo
    func deleteToDo(toDo: ToDo) {
        guard let toDoId = toDo.id else { return }
        
        //callback
        db.collection("toDos").document(toDoId).delete { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
