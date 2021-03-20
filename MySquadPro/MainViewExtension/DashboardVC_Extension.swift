//
//  DashboardVC_Extension.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

import UIKit

extension DashboardController {
    
     func setupTitleView() {
        
        // Anchor titleview background
        titleViewBackground.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        titleViewBackground.heightAnchor.constraint(equalToConstant: 1/10 * UIScreen.main.bounds.height).isActive = true
        titleViewBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleViewBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //Anchor titleview
         titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 13).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleViewBackground.centerYAnchor, constant: 23).isActive = true
        
        // Anchor list button
        dotButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        dotButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        dotButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        dotButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Anchor calendar button
        calendarButton.rightAnchor.constraint(equalTo: dotButton.leftAnchor, constant: -30).isActive = true
        calendarButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        calendarButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        calendarButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
  
    
}



