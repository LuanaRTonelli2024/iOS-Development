//
//  ContentView.swift
//  Firebase ToDo App
//
//  Created by user285344 on 11/7/25.
//

import SwiftUI
import FirebaseCore

struct ContentView: View {
    
    @State private var newToDoTitle: String = ""
    @StateObject var firebaseManager = FirebaseViewModel.shared
    var body: some View {
        VStack {
            //list
            List {
                ForEach(firebaseManager.toDos){
                    toDo in
                    
                    HStack{
                        //title
                        Text(toDo.title)
                            .strikethrough(toDo.isDone, color: .black)
                        
                        //spacer
                        Spacer()
                        
                        //toggle
                        Toggle(isOn: Binding(get: {toDo.isDone}, set: {newValue in firebaseManager.updateToDoStatus(toDo: toDo, isDone: newValue)})) {
                                EmptyView()
                        }
                    }
                }.onDelete(perform: deleteToDo)
                //end of foreach ---> swipe to delete
            }.onAppear {
                if !firebaseManager.toDos.isEmpty {
                    Task {
                        firebaseManager.fetchToDos()
                    }
                }
            }
            
            HStack {
                //TextField
                TextField("Enter a new ToDo", text: $newToDoTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                //Add button
                Button {
                    if !newToDoTitle.isEmpty {
                        firebaseManager.addToDo(title: newToDoTitle)
                        //reset the ToDo title
                        newToDoTitle = ""
                    }
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        .padding()
    }
    
    private func deleteToDo(at offsets: IndexSet) {
        offsets.forEach { index in
            let toDo = firebaseManager.toDos[index]
            
            firebaseManager.deleteToDo(toDo: toDo)
        }
    }
}

#Preview {
    ContentView()
}
