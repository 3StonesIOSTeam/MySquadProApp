//
//  TeamListPickerControllerViewController.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/16/21.
//

import UIKit
import FirebaseFirestore

class TeamListPickerController: UIViewController {
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var characters: [String]? {
        didSet {
            print("new")
        }
    }
    var NewEventControllerDelegate: NewEventController?
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
        safeArea = view.layoutMarginsGuide
        setupTableView()
        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.6)
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(CheckableTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
