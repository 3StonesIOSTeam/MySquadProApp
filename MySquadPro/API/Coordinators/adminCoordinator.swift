//
//  adminCoordinator.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

public class adminCoordinator: adminDelegate, Coordinator{
   
    private var username: String
    
    public init(username: String, accessCode: String) {
        self.username = username
    }
    
    //MARK: PROTOCAL METHODS
    func savePost() {
        //
    }
    
    func editPosts() {
        //
    }
    
}
