//
//  CalendarController.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/8/21.
//

import UIKit
import FSCalendar
import FirebaseFirestore

class CalendarController: UIViewController, UIGestureRecognizerDelegate {
    
    let db = Firestore.firestore()
    var calendar:FSCalendar!
    var customizer = DateFormatter()
    var userToken: User?
    
    var data: [EventModel]? {
        didSet {
            print("Reloaded")
            collectionView.reloadData()
        }
    }
    var dict: [String: [EventModel]]? = ["": [EventModel(eventID: nil, eventTitle: nil, eventDescription: nil)]]{
        didSet {
            print("added something to dict")
            calendar.reloadData()
        }
    }
    
    lazy var calendarBackground: UIView = {
        let cb = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        cb.backgroundColor = .black
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    
    let collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.size.width
        flowlayout.estimatedItemSize = CGSize(width: width, height: 80)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CalendarEventCell.self, forCellWithReuseIdentifier: "cell")
        return cv
        
    }()
    
    
    lazy var longPressGesture: UILongPressGestureRecognizer = {
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        return lpgr
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        resetCalendar()
        fetchEvents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        // INITIALIZE A FSCALENDAR
        calendar = FSCalendar(frame:CGRect(x: 0.0, y: 0.0, width:self.view.frame.width, height: (self.view.frame.height/2) - 70))
        calendar.scrollDirection = .horizontal
        calendar.scope = .month
        calendar.locale=Locale(identifier:"en_US")
        calendar.placeholderType = .none
        
        view.addSubview(calendarBackground)
        view.addSubview(calendar)
        
        // CALENDAR APPEARENCE
        calendar.appearance.todayColor = .red
        calendar.appearance.titleTodayColor = .white
        calendar.appearance.titleDefaultColor = .white
        calendar.appearance.weekdayFont = UIFont.boldSystemFont(ofSize:20)
        calendar.appearance.weekdayTextColor = .white
        calendar.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 24)
        calendar.appearance.headerTitleColor = .red
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.thin)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.3
        calendar.appearance.eventSelectionColor = .orange
        calendar.appearance.eventDefaultColor = .orange
        calendar.appearance.eventOffset = CGPoint(x: 0.5, y: 5.0)
        
        // CALENDAR DELEGATE AND DATA SOURCE
        calendar.allowsMultipleSelection = false
        calendar.dataSource = self
        calendar.delegate = self
        
        
        
        // INITIALIZE COLLECTION VIEW
        view.addSubview(collectionView)
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/2).isActive = true
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addGestureRecognizer(longPressGesture)
        getTodayEvents()
        
        
    }
    
    
    
}
