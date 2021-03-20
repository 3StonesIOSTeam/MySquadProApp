//
//  newEvent_Extension.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/14/21.
//

import Foundation
import FSCalendar
import FirebaseFirestore

extension NewEventController {
    
    //MARK: - CALENDAR DELEGATE
    func minimumDate(for calendar:FSCalendar) -> Date{
        return Date()
    }
    
    func calendar(_ calendar:FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        customizer.dateFormat = "MM-dd-yyyy"
        let newDate = customizer.string(from: date)
    }
    
    //MARK: - TEXTVIEW DELEGATE
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.white.withAlphaComponent(0.3) {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Event Description"
            textView.textColor = UIColor.white.withAlphaComponent(0.3)
        }
    }
    
    
    
    
    //MARK: - OTHER FUNCTIONS
    func fetchTeamsList() {
        
        let token = calendarControllerDelegate!.userToken!
        tp.NewEventControllerDelegate = self
        
        switch token.userAccesstype() {
        case .admin:
            (token.coordinator as! adminCoordinator).performDatabaseQuery(fetchType: .teams) { (arr, err) in
                if err == nil {
                    self.tp.characters = (arr!)
                }
            }
            break
            
        case .staff:
            (token.coordinator as! staffCoordinator).performDatabaseQuery(fetchType: .teams) { (arr, err) in
                if err == nil {
                    self.tp.characters = (arr!)
                }
            }
            break
            
        default:
            break
        }
        
    }
    
    
    @objc func handleBack() {
        self.calendarControllerDelegate!.resetCalendar()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSave() {
        
        customizer.dateFormat = "MM-dd-yyyy"
        let newDate = customizer.string(from: calendar2.selectedDate!)
        let token = calendarControllerDelegate!.userToken!
        let event = EventModel(eventID: UUID().uuidString, eventTitle: eventTitleTextfield.text, eventDescription: eventDescriptionTextfield.text)
        
        
        db.collection(token.getUserProperty(propertyType: .club) as! String).document("event_database").collection("events").document(event.eventID!).setData(["ID": event.eventID!, "Date": newDate, "Title": event.eventTitle!, "Description": event.eventDescription!]) { (err) in
            if err == nil {
                print("Saved Event")
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Event Error")
            }
        }
    }
    
    @objc func handleTap() {
        self.navigationController?.pushViewController(tp, animated: true)
    }
    
    @objc func handleTap2() {
        let trc = TimeAndReccurenceController()
        let navigationController2 = UINavigationController(rootViewController: trc)
        navigationController2.navigationBar.barTintColor = UIColor.gray.withAlphaComponent(0.7)
        present(navigationController2, animated: true)
    }
}

