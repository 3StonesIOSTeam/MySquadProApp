//
//  staffDelegate.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

import Foundation

protocol staffDelegate {
    
    func savePost(post: Post)
    func editPost(id: String, subject: String, text: String)
    func fetchPosts()
    
    func performDatabaseQuery(fetchType: userQueryType, completion: @escaping (([String]?, appErrors?) -> ()))
    func registerUserInTeam(withname: String, email: String, completion: @escaping ((appErrors?) -> ()))
}
