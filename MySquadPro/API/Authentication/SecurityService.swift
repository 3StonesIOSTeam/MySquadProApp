//
//  SecurityService.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


final class SecurityService {
    
    private var username: String
    private var password: String
    private var name: String?
    private var accessCode: String?
    private var path: String
    private let db = Firestore.firestore()
    
    // Init method for login.
    init(withEmail: String, password: String, organization: String) {
        self.username = withEmail
        self.password = password
        self.path = organization
    }
    
    // Init method for new registration.
    init(name: String, withEmail: String, password: String, accessCode: String, organization: String) {
        self.username = withEmail
        self.password = password
        self.accessCode = accessCode
        self.path = organization
        self.name = name
    }
    
    func authenticateUser(completion: @escaping ((User) -> ())) {
      
        
        Auth.auth().signIn(withEmail: self.username, password: self.password) { [self] (result, err) in
            if err == nil {
                db.collection(self.path).document("user_database").collection("users").document(self.username).getDocument { (doc, err) in
                    if err == nil {
                        let data = doc?.data()
                        
                        switch (data!["type"] as! String) {
                        case "admin":
                            let cc = User(name: data!["name"] as! String, username: self.username, type: .admin, club: self.path, teams: data!["teams"] as! [String])
                            print("authenticated")
                            completion(cc)
                            break
                            
                        case "staff":
                            let cc = User(name: data!["name"] as! String, username: self.username, type: .staff, club: self.path, teams: data!["teams"] as! [String])
                            completion(cc)
                            break
                            
                        case "player":
                            let cc = User(name: data!["name"] as! String, username: self.username, type: .player, club: self.path, teams: data!["teams"] as! [String])
                            completion(cc)
                            break
                            
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
    
    func registerUser(completion: @escaping ((User) -> ())) {
   
        Auth.auth().createUser(withEmail: self.username, password: self.password) { [self] (result, err) in
            
            print("signing in....")
            
            if err == nil {
                db.collection(self.path).document("access_codes").getDocument { (doc, err) in
                    print("getting access codes...........")
                    if err == nil {
                        
                        let data = doc?.data()
                        let usertype = data!["\(self.accessCode!)"] as! String
                        
                        db.collection(self.path).document("user_database").collection("users").document(self.username).setData(["email":self.username, "name":self.name!, "type":usertype, "teams": [String]()])
                        
                        switch usertype {
                        case "admin":
                            let cc = User(name: self.name!, username: self.username, type: .admin, club: self.path, teams: [String]())
                            completion(cc)
                            break
                        case "staff":
                            let cc = User(name: self.name!, username: self.username, type: .staff, club: self.path, teams: [String]())
                            completion(cc)
                            break
                        case "player":
                            let cc = User(name: self.name!, username: self.username, type: .player, club: self.path, teams: [String]())
                            completion(cc)
                            break
                            
                        default:
                            break
                        }
                    }
                }
                
            }
        }
        
        
    }
    
    
    
}
