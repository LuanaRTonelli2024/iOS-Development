//
//  AppUser.swift
//  Firebase Practice
//
//  Created by user285344 on 11/11/25.
//

import Foundation
import FirebaseFirestore

struct AppUser: Identifiable, Codable {
    
    @DocumentID var id: String? //FirebaseAuth.currentUser.uid
    let email: String //canot be changed after
    var displayName: String
    var isActive: Bool = true
}
