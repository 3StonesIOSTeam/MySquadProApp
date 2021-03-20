//
//  DashboardController.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

import Foundation
import UIKit
import FSCalendar

class DashboardController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calendar:FSCalendar!
    let customizer=DateFormatter()
    
    private var userToken: User? {
        didSet {
            print("userToken info: \(userToken!.toString())")
        }
    }

    let titleViewBackground: UIView = {
        
        // Background color
        let bg = UIView()
        bg.backgroundColor = .red
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
  
    
    let titleLabel: UILabel = {
    
        // Title Label
        let lb = UILabel()
        lb.textAlignment = .center
        lb.text = "MY SQUAD APP"
        lb.numberOfLines=1
        lb.textColor = UIColor.white
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lb.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        return lb
    }()
    
    let dotButton: UIButton = {
       
        // Button
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.dash"), for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dotaction), for: .touchUpInside)
        return button
    }()
    
    let calendarButton: UIButton = {
       
        // Button
        let button = UIButton()
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = .white
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(calendaraction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create TitleView for controller
        view.addSubview(titleViewBackground)
        titleViewBackground.addSubview(titleLabel)
        titleViewBackground.addSubview(calendarButton)
        titleViewBackground.addSubview(dotButton)
        
        // Constraint TitleView elements
        setupTitleView()
        
    }
    
    
    @objc func calendaraction() {
        let rootVC = CalendarController()
        rootVC.userToken = userToken
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.isModalInPresentation = false
        present(navVC, animated: true)
    }
    
    @objc func dotaction() {
        let sc = SecurityService(withEmail: "test4@gmail.com", password: "kkkkkk", organization: "Orioles")
        sc.authenticateUser { (User) in
            self.userToken = (User.copy() as! User)
        }
        
   
        
        
    }
    
    
}

