//
//  calendar_Extension.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/10/21.
//

import Foundation
import FSCalendar

extension CalendarController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    //MARK: - CALENDAR DELEGATE
    func minimumDate(for calendar:FSCalendar) -> Date{
        return Date()
    }
    
    func calendar(_ calendar:FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        customizer.dateFormat = "MM-dd-yyyy"
        let newDate = customizer.string(from: date)
        
        if self.dict!.keys.contains(newDate) {
            self.data = self.dict![newDate]!
        }
        else {
            self.data = [EventModel(eventID: nil, eventTitle: nil, eventDescription: nil)]
        }
        collectionView.reloadData()
        
    }
    
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition){
        customizer.dateFormat = "MM-dd-yyyy"
        //getTodayEvents()
        
    }
    
    
    func calendar(_ calendar:FSCalendar, numberOfEventsFor date:Date) -> Int {
        customizer.dateFormat = "MM-dd-yyyy"
        let newDate = customizer.string(from: date)
        
        if self.dict!.keys.contains(newDate){
            return self.dict![newDate]!.count
        }
        return 0
    }
    
    
    //MARK: - NAVIGATION BAR
    func setupNavBar() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        
        let image = UIImage(systemName: "xmark")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleClose))
        
        let image2 = UIImage(systemName: "plus")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image2, style: .plain, target: self, action: #selector(handleAdd))
    }
    
    
    //MARK: - BUTTON ACTIONS
    func getTodayEvents() {
        customizer.dateFormat = "MM-dd-yyyy"
        let newDate = customizer.string(from: Date())
        
        if self.dict!.keys.contains(newDate) {
            self.data = self.dict![newDate]!
        }
        else {
            self.data = [EventModel(eventID: nil, eventTitle: nil, eventDescription: nil)]
        }
        collectionView.reloadData()
        calendar.reloadData()
    }
    
    
    @objc private func handleClose() {
        self.resetCalendar()
        self.dismiss(animated: true)
    }
    
    @objc private func handleAdd() {
        let ec = NewEventController()
        ec.calendarControllerDelegate = self
        self.data?.removeAll()
        self.dict?.removeAll()
        self.navigationController?.pushViewController(ec, animated: true)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }
        
        let p = gestureRecognizer.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: p) {
           
            let event = self.data![indexPath.row]
            if self.data![indexPath.row].eventTitle != nil {
                
                customizer.dateFormat = "MM-dd-yyyy"
                let selectedDate = customizer.string(from: (calendar.selectedDate ?? calendar.today)!)
                
                
                db.collection(userToken!.getUserProperty(propertyType: .club) as! String).document("event_database").collection("events").document(event.eventID!).delete { (err) in
                    if err == nil {
                        if self.data?.count == 1 {
                            self.dict!.remove(at: (self.dict?.index(forKey: selectedDate))!)
                            self.data = [EventModel(eventID: nil, eventTitle: nil, eventDescription: nil)]
                        } else {
                            self.dict![selectedDate]?.remove(at: indexPath.row)
                            self.data?.remove(at: indexPath.row)
                        }
                    }
                }
                
                calendar.reloadData()
                collectionView.reloadData()
            }
        }
    }
    
    func resetCalendar() {
        guard let _ = calendar.selectedDate else { return }
        
        if calendar.selectedDate! != Date() {
            calendar.deselect(calendar.selectedDate!)
        }
        
        getTodayEvents()
    }
    
    func fetchEvents() {
        let token = userToken!
        
        db.collection(token.getUserProperty(propertyType: .club) as! String).document("event_database").collection("events").getDocuments { (snap, err) in
            if err == nil {
                
                for doc in snap!.documents {
                    let data = doc.data()
                    let date = data["Date"] as! String
                    
                    if self.dict!.keys.contains(date) == true {
                        self.dict![date]!.append(EventModel(eventID: doc.documentID, eventTitle: (data["Title"] as! String), eventDescription: (data["Description"] as! String)))
                    } else {
                        self.dict![date] = [EventModel(eventID: doc.documentID, eventTitle: (data["Title"] as! String), eventDescription: (data["Description"] as! String))]
                    }
                    
                }
            }
        }
    }
    
}


//MARK: - EVENT COLLECTION VIEW
extension CalendarController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let _ = self.data else { return 0 }
        if self.data!.count == 0 {
            return 0
        } else {
            return self.data!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarEventCell
        cell.backgroundColor = .black
        cell.data = self.data![indexPath.row]
        return cell
        
    }
    
    
}
