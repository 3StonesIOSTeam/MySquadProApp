//
//  ChallengeController.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

import UIKit
import Foundation

class ChallengeController: UIViewController {

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
        lb.text = "CHALLENGES"
        lb.numberOfLines = 1
        lb.textColor = UIColor.white
        lb.font = UIFont.boldSystemFont(ofSize: 25)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create TitleView for controller
        view.addSubview(titleViewBackground)
        titleViewBackground.addSubview(titleLabel)
        
        // Constraint TitleView elements
        setupTitleView()
        
    }

}

