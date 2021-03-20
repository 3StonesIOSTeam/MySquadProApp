//
//  NoteModel.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/21/21.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

final class Post {
    
    let id: String
    var subject: String
    var text: String
    var created: Timestamp
    var author: String
    
    let db = Firestore.firestore()
    
    init(subject: String, text: String, author: String) {
        self.id = UUID().uuidString
        self.subject = subject
        self.text = text
        self.author = author
        self.created = Timestamp(date: Date())
    }
    
    
}
