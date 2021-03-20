//
//  adminCoordinator.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

final class adminCoordinator: adminDelegate, Coordinator {
   
    private var username: String
    private var time: Date?
    private let db = Firestore.firestore()
    private var path: String
    
    
    init(username: String, path: String) {
        self.username = username
        self.path = path
    }
    
    //MARK: PROTOCAL METHODS
    func savePost(post: Post) {
        db.collection(self.path).document("post_database").collection("posts").document("\(post.id)").setData(["subject":post.subject, "text":post.text, "created":post.created, "author":post.author]) { (err) in
            if err != nil {
                print("Error saving!")
            }
        }
        
    }
    
    
    func editPost(id: String, subject: String, text: String) {
        db.collection(self.path).document("post_database").collection("posts").document(id).setData(["subject": subject, "text": text]) { (err) in
            if err != nil {
                print("Error edit.")
            }
        }
    }
    
    
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
    
    
    func addTeamToDatabase(withname: String) {
        db.collection(self.path).document("team_database").getDocument { [self] (doc, err) in
            if err == nil {
                
                guard let data = doc?.data() else {
                    db.collection(self.path).document("team_database").setData(["teams":[withname]]) { (err) in
                        if err == nil {
                            print("created a new team array.")
                        }
                    }
                    
                    return
                }
                
                var arr = (data["teams"] as? [String])
                arr!.append(withname)
                
                db.collection(self.path).document("team_database").updateData(["teams":arr]) { (err) in
                    if err == nil {
                        print("added team")
                    }
                }
            }
        }
    }
    
    
    //MARK: TEAM METHODS
    func performDatabaseQuery(fetchType: userQueryType, completion: @escaping (([String]?, appErrors?) -> ())) {
        
        switch fetchType {
        
        case .users:
            db.collection(self.path).document("user_database").collection("users").getDocuments { (query, err) in
                
                guard err == nil else {
                    completion(nil, .FirestoreQueryError)
                    return
                }
                var result = [String]()
                for doc in query!.documents {
                    let data = doc.data()
                    result.append(data["email"] as! String)
                }
                completion(result, nil)
            }
            break
        
        case .teams:
            db.collection(self.path).document("team_database").getDocument { (doc, err) in
                guard err == nil else {
                    completion(nil, .FirestoreQueryError)
                    return
                }
                let data = doc!.data()
                completion((data!["teams"] as! [String]), nil)
            }
            break
        }
        
        
    }
    
    func registerUserInTeam(withname: String, email: String, completion: @escaping ((appErrors?) -> ())) {
        db.collection(self.path).document("user_database").collection("users").document(email).getDocument { [self] (doc, err) in
            guard err == nil else {
                completion(.FirestoreQueryError)
                return
            }
                let data = doc?.data()
                var player_teams = data!["teams"] as! [String]
            
                if player_teams.count >= 9 { completion(appErrors.TeamCapacityFull) }
                else {
                    player_teams.append(withname)
                    db.collection(self.path).document("user_database").collection("users").document(email).updateData(["teams" : player_teams])
                    completion(nil)
                }
        }
    }
    
}




