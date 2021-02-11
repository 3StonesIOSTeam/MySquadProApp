//
//  MoviesVC_Extension.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 2/10/21.
//

import Foundation
import UIKit

extension MoviesController {
    
    func setupTitleView() {
        
        // Anchor titleview background
        titleViewBackground.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        titleViewBackground.heightAnchor.constraint(equalToConstant: 1/10 * UIScreen.main.bounds.height).isActive = true
        titleViewBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleViewBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //Anchor titleview
         titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleViewBackground.centerYAnchor, constant: 23).isActive = true
    }
}
