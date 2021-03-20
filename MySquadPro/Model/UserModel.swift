//
//  User.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

import Foundation

final class User: NSObject, NSCopying {
    
    private var name: String
    private var username: String
    private var club: String
    private var teams: [String]
    private var type: UserType
    var coordinator: Coordinator?
 
    
    init(name: String, username: String, type: UserType, club: String, teams: [String]) {
        self.name = name
        self.username = username
        self.type = type
        self.club = club
        self.teams = teams
        
        switch type {
        case .admin:
            self.coordinator = adminCoordinator(username: username, path: club)
            print("created admin co in user")
            break
            
        case .staff:
            self.coordinator = staffCoordinator(username: username, path: club)
            print("created staff co")
            break
            
        case .player:
            self.coordinator = playerCoordinator(username: username, path: club)
            print("created player co")
            break
            
        default:
            print("created nil co")
            break
        }
    }
    
    func toString() -> String {
        return "name: \(self.name) -- username: \(self.username) -- type: \(type.rawValue)"
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = User(name: self.name, username: self.username, type: self.type, club: self.club, teams: self.teams)
        return copy
    }
    
    func userAccesstype() -> UserType {
        return type
    }
    
    func getUserProperty(propertyType: propertyType) -> Any {
        switch propertyType {
        case .club:
            return self.club
        case .username:
            return self.username
        case .teams:
            return self.teams
        }
    }

    
}


