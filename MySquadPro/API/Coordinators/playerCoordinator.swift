//
//  playerCoordinator.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/11/21.
//

import Foundation
import FirebaseFirestore

final class playerCoordinator: playerDelegate, Coordinator {
 
    
    private var username: String
    private var time: Date?
    private let db = Firestore.firestore()
    private var path: String

    required init(username: String, path: String) {
        self.username = username
        self.path = path
    }
    
    //MARK: PROTOCAL METHODS
    func fetchPosts() {
        db.collection(self.path).document("post_database").collection("posts").getDocuments { (snapshot, err) in
            if err == nil {
                let queryDocs = snapshot!.documents
                
                for doc in queryDocs {
                    let data = doc.data()
                    print("ID: \(doc.documentID) ---- SUBJECT: \(data["subject"] as! String) ---- TEXT: \(data["text"] as! String)")
                }
            }
        }
    }
    
    
}
