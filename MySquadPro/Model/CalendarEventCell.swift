//
//  CalendarEventCell.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/10/21.
//

import Foundation
import UIKit

public class CalendarEventCell: UICollectionViewCell {
    
    var data: EventModel? {
        didSet {
            if data!.eventTitle != nil && data!.eventDescription != nil {
                eventTitle.text = data!.eventTitle
                eventDescription.text = data!.eventDescription
                
            } else {
                eventTitle.text = "No Events For Selected Date"
                eventDescription.text = ""
            }
        }
    }
    
    let bg: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "image")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var eventTitle: UILabel = {
        var label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.text = "Team Meeting"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var eventDescription: UILabel = {
        var label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(eventTitle)
        contentView.addSubview(eventDescription)
        setupCell()
        
    }
    
    
    func setupCell() {
        eventTitle.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        eventTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
       
        eventDescription.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 10).isActive = true
        eventDescription.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        eventDescription.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: eventDescription.bottomAnchor, constant: 10).isActive = true
       
    }
    
    
    public override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
}
