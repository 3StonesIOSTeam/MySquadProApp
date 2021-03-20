//
//  Enums.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/6/21.
//

import Foundation

enum UserType: String {
    case admin = "admin"
    case staff = "staff"
    case player = "player"
    case none = "nil"
}


enum appErrors: Error {
    case TeamCapacityFull
    case FirestoreQueryError
    case noError
}


enum userQueryType {
    case users
    case teams
}

enum propertyType {
    case username
    case teams
    case club
}
