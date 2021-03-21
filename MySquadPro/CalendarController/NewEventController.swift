//
//  EventController.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/10/21.
//

import UIKit
import SwiftUI
import FSCalendar
import FirebaseFirestore

class NewEventController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    let db = Firestore.firestore()
    let tp = TeamListPickerController()
    var calendarControllerDelegate: CalendarController?
    var calendar2:FSCalendar!
    var customizer = DateFormatter()
    var tickCount:Int = 0 {
        didSet {
            print("tick count")
            tickCountLabel.setTitle("(\(tickCount))", for: .normal)
        }
    }
    
    var eventArray: [EventModel]?
    
    lazy var calendarBackground: UIView = {
        let cb = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        cb.backgroundColor = .black
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    
    lazy var eventInfoBackground: UIView = {
        let cb = UIView(frame: .zero)
        cb.backgroundColor = #colorLiteral(red: 0.1607654989, green: 0.1647180617, blue: 0.1882076561, alpha: 0.9379360376)
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    
    lazy var navigationlinkBackground: UIButton = {
        let cb = UIButton(frame: .zero)
        cb.backgroundColor = #colorLiteral(red: 0.1607654989, green: 0.1647180617, blue: 0.1882076561, alpha: 0.9379360376)
        cb.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    lazy var navigationlink2Background: UIButton = {
        let cb = UIButton(frame: .zero)
        cb.backgroundColor = #colorLiteral(red: 0.1607654989, green: 0.1647180617, blue: 0.1882076561, alpha: 0.9379360376)
        cb.addTarget(self, action: #selector(handleTap2), for: .touchUpInside)
        cb.translatesAutoresizingMaskIntoConstraints = false
        return cb
    }()
    
    lazy var navigationlinkTitle: UIButton = {
        var label = UIButton(frame: .zero)
        label.setTitle("Select Team:", for: .normal)
        label.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        label.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        label.contentHorizontalAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var navigationlink2Title: UIButton = {
        var label = UIButton(frame: .zero)
        label.setTitle("Set Time and Cycle", for: .normal)
        label.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        label.addTarget(self, action: #selector(handleTap2), for: .touchUpInside)
        label.contentHorizontalAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var tickCountLabel: UIButton = {
        var label = UIButton(frame: .zero)
        label.setTitle("(0)", for: .normal)
        label.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
        label.titleLabel?.textAlignment = .right
        label.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let eventTitleTextfield: UITextField = {
        let txtField: UITextField = UITextField(frame:.zero)
        txtField.textColor = .white
        txtField.backgroundColor = .clear
        txtField.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        txtField.attributedPlaceholder = NSAttributedString(string: "Event Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)])
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
        
    }()
    
    lazy var eventDescriptionTextfield: UITextView = {
        let txtField: UITextView = UITextView(frame:.zero)
        txtField.textColor = UIColor.white.withAlphaComponent(0.3)
        txtField.text = "Event Description"
        txtField.backgroundColor = .clear
        txtField.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        txtField.isEditable = true
        txtField.delegate = self
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
        
    }()
    
    lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.preferredDatePickerStyle = .automatic
        dp.backgroundColor = #colorLiteral(red: 0.1607654989, green: 0.1647180617, blue: 0.1882076561, alpha: 0.9379360376)
        dp.tintColor = .white
        dp.locale = .current
        dp.datePickerMode = .time
        dp.layer.masksToBounds = true
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        
        navigationItem.title = "Add Event"
        UINavigationBar().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        let image = UIImage(systemName: "chevron.left")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleBack))
        
        let image2 = UIImage(systemName: "checkmark")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image2, style: .plain, target: self, action: #selector(handleSave))
        
        // INITIALIZE A FSCALENDAR
        calendar2 = FSCalendar(frame:CGRect(x: 0.0, y: 0.0, width:self.view.frame.width, height: self.view.frame.height/2 - 70))
        calendar2.scrollDirection = .horizontal
        calendar2.scope = .month
        calendar2.locale=Locale(identifier:"en_US")
        calendar2.placeholderType = .none
        
        view.addSubview(calendarBackground)
        view.addSubview(calendar2)
        
        // CALENDAR APPEARENCE
        calendar2.appearance.todayColor = .red
        calendar2.appearance.titleTodayColor = .white
        calendar2.appearance.titleDefaultColor = .white
        calendar2.appearance.weekdayFont = UIFont.boldSystemFont(ofSize:20)
        calendar2.appearance.weekdayTextColor = .white
        calendar2.appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 24)
        calendar2.appearance.headerTitleColor = .red
        calendar2.appearance.titleFont = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.thin)
        calendar2.appearance.headerMinimumDissolvedAlpha = 0.3
        calendar2.appearance.eventSelectionColor = .orange
        calendar2.appearance.eventDefaultColor = .orange
        calendar2.appearance.eventOffset = CGPoint(x: 0.5, y: 5.0)
        
        // CALENDAR DELEGATE AND DATA SOURCE
        calendar2.allowsMultipleSelection = false
        calendar2.dataSource = self
        calendar2.delegate = self
        
        view.addSubview(eventInfoBackground)
        setupForm()
        fetchTeamsList()
        
        
        
    }
    
    fileprivate func setupForm() {
        eventInfoBackground.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        eventInfoBackground.heightAnchor.constraint(equalToConstant: view.frame.height/4 - 30).isActive = true
        eventInfoBackground.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        eventInfoBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        eventInfoBackground.addSubview(eventTitleTextfield)
        eventInfoBackground.addSubview(eventDescriptionTextfield)
        
        setupTextFields()
    }
    
    fileprivate func setupTextFields() {
        eventTitleTextfield.centerXAnchor.constraint(equalTo: eventInfoBackground.centerXAnchor).isActive = true
        eventTitleTextfield.topAnchor.constraint(equalTo: eventInfoBackground.topAnchor).isActive = true
        eventTitleTextfield.widthAnchor.constraint(equalTo: eventInfoBackground.widthAnchor, constant: -20).isActive = true
        eventTitleTextfield.heightAnchor.constraint(equalTo: eventInfoBackground.heightAnchor, constant: -150).isActive = true
        
        let divider: UIView = UIView(frame: .zero)
        divider.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        eventInfoBackground.addSubview(divider)
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.widthAnchor.constraint(equalTo: eventTitleTextfield.widthAnchor, constant: 20).isActive = true
        divider.topAnchor.constraint(equalTo: eventTitleTextfield.bottomAnchor, constant: 5).isActive = true
        divider.leftAnchor.constraint(equalTo: eventTitleTextfield.leftAnchor).isActive = true
        
        eventDescriptionTextfield.centerXAnchor.constraint(equalTo:eventInfoBackground.centerXAnchor).isActive = true
        eventDescriptionTextfield.widthAnchor.constraint(equalTo: eventInfoBackground.widthAnchor, constant: -15).isActive = true
        eventDescriptionTextfield.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 7).isActive = true
        eventDescriptionTextfield.bottomAnchor.constraint(equalTo: eventInfoBackground.bottomAnchor, constant: -5).isActive = true
        
        
        view.addSubview(navigationlinkBackground)
        
        navigationlinkBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navigationlinkBackground.heightAnchor.constraint(equalTo: eventTitleTextfield.heightAnchor, constant: -5).isActive = true
        navigationlinkBackground.topAnchor.constraint(equalTo: eventInfoBackground.bottomAnchor, constant: 20).isActive = true
        navigationlinkBackground.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
        
        let ig = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .right
        imageView.tintColor = UIColor.white.withAlphaComponent(0.7)
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.image = ig
        imageView.translatesAutoresizingMaskIntoConstraints = false
       

        
        navigationlinkBackground.addSubview(navigationlinkTitle)
        navigationlinkBackground.addSubview(imageView)
        
        navigationlinkTitle.centerYAnchor.constraint(equalTo: navigationlinkBackground.centerYAnchor).isActive = true
        navigationlinkTitle.heightAnchor.constraint(equalTo: navigationlinkBackground.heightAnchor, constant: -5).isActive = true
        navigationlinkTitle.widthAnchor.constraint(equalTo: navigationlinkBackground.widthAnchor, multiplier: 1/3).isActive = true
       
        
        
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalTo: navigationlinkBackground.heightAnchor, multiplier: 1/2).isActive = true
        imageView.rightAnchor.constraint(equalTo: navigationlinkBackground.rightAnchor, constant: -15).isActive = true
        imageView.centerYAnchor.constraint(equalTo: navigationlinkBackground.centerYAnchor).isActive = true
        
        navigationlinkBackground.addSubview(tickCountLabel)
        tickCountLabel.centerYAnchor.constraint(equalTo: navigationlinkBackground.centerYAnchor).isActive = true
        tickCountLabel.heightAnchor.constraint(equalTo: navigationlinkBackground.heightAnchor, constant: -5).isActive = true
        tickCountLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor, constant: 30).isActive = true
        tickCountLabel.rightAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        
        let divider2: UIView = UIView(frame: .zero)
        divider2.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        divider2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(divider2)
         divider2.heightAnchor.constraint(equalToConstant: 1).isActive = true
         divider2.widthAnchor.constraint(equalTo: navigationlinkBackground.widthAnchor, constant: 20).isActive = true
         divider2.topAnchor.constraint(equalTo: navigationlinkBackground.bottomAnchor, constant: 0).isActive = true
         divider2.leftAnchor.constraint(equalTo: divider.leftAnchor).isActive = true
        
        
        // NAVIGATION LINK 2 BACKGROUND
        view.addSubview(navigationlink2Background)
        navigationlink2Background.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        navigationlink2Background.heightAnchor.constraint(equalTo: eventTitleTextfield.heightAnchor, constant: -5).isActive = true
        navigationlink2Background.topAnchor.constraint(equalTo: divider2.bottomAnchor).isActive = true
        navigationlink2Background.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
        navigationlink2Background.addSubview(navigationlink2Title)
        navigationlink2Title.centerYAnchor.constraint(equalTo: navigationlink2Background.centerYAnchor).isActive = true
        navigationlink2Title.heightAnchor.constraint(equalTo: navigationlink2Background.heightAnchor, constant: -5).isActive = true
        navigationlink2Title.widthAnchor.constraint(equalTo: navigationlink2Background.widthAnchor, multiplier: 2/3).isActive = true
        navigationlink2Title.leftAnchor.constraint(equalTo: divider2.leftAnchor).isActive = true
        
        navigationlinkTitle.leftAnchor.constraint(equalTo: divider2.leftAnchor).isActive = true
        
        
        
    }
    
    
    
   
}
