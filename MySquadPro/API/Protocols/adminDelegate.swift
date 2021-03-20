//
//  adminDelegate.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

import Foundation

protocol adminDelegate {

    func savePost(post: Post)
    func editPost(id: String, subject: String, text: String)
    func fetchPosts()
    func addTeamToDatabase(withname: String)
    
    // Team Methods
    func performDatabaseQuery(fetchType: userQueryType, completion: @escaping (([String]?, appErrors?) -> ()))
    func registerUserInTeam(withname: String, email: String, completion: @escaping ((appErrors?) -> ()))
    
}
