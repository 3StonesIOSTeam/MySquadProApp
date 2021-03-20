//
//  EventModel.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/10/21.
//

import Foundation

class EventModel {
    
    var eventID: String?
    var eventTitle: String?
    var eventDescription: String?
    
    init(eventID: String?, eventTitle: String?, eventDescription: String?) {
        self.eventID = eventID
        self.eventTitle = eventTitle
        self.eventDescription = eventDescription
    }
}
