//
//  TimeAndReccurence_Extension.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/18/21.
//

import Foundation
import UIKit

extension TimeAndReccurenceController {
    
    
    @objc func handleBack() {
        self.dismiss(animated: true)
    }
    
    @objc func handleDone() {
        self.dismiss(animated: true)
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm aa"
        
        switch selectedTag {
        
        case 1:
            startTimePickerlb.text = dateFormatter.string(from: picker.date)
            calculateDurTime()
            break
            
        case 2:
            endTimePickerlb.text = dateFormatter.string(from: picker.date)
            calculateDurTime()
            break
            
        default:
            break
            
        }
        
        
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        let tappedView: UIView = (sender.view!)
        
        switch tappedView.tag {
        case 1:
            if tappedView.backgroundColor == UIColor.clear { tappedView.backgroundColor = .red } else { tappedView.backgroundColor = .clear }
            break
            
        case 2:
            if tappedView.backgroundColor == UIColor.clear { tappedView.backgroundColor = .red } else { tappedView.backgroundColor = .clear }
            break
            
        case 3:
            if tappedView.backgroundColor == UIColor.clear { tappedView.backgroundColor = .red } else { tappedView.backgroundColor = .clear }
            break
            
        case 4:
            if tappedView.backgroundColor == UIColor.clear { tappedView.backgroundColor = .red } else { tappedView.backgroundColor = .clear }
            break
            
        case 5:
            if tappedView.backgroundColor == UIColor.clear { tappedView.backgroundColor = .red } else { tappedView.backgroundColor = .clear }
            break
            
        case 6:
            if tappedView.backgroundColor == UIColor.clear { tappedView.backgroundColor = .red } else { tappedView.backgroundColor = .clear }
            break
            
        case 7:
            if tappedView.backgroundColor == UIColor.clear { tappedView.backgroundColor = .red } else { tappedView.backgroundColor = .clear }
            break
            
        default:
            break
        }
    }
    
    @objc func timeLabelTapped(_ sender: UITapGestureRecognizer) {
        let tappedView: UIView = (sender.view!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm aa"
        
        switch tappedView.tag {
        case 1:
            startTimeStack(isSelected: true)
            endTimeStack(isSelected: false)
            self.picker.date = dateFormatter.date(from: startTimePickerlb.text!)!
            selectedTag = tappedView.tag
            break
            
        case 2:
            startTimeStack(isSelected: false)
            endTimeStack(isSelected: true)
            
            self.picker.date = dateFormatter.date(from: endTimePickerlb.text!)!
            selectedTag = tappedView.tag
            break
            
        default:
            break
        }
    }
    
    func startTimeStack(isSelected: Bool) {
        
        if isSelected {
            startTimeTitleImage.tintColor = .systemRed
            startTimeTitlelb.textColor = .systemRed
            startTimePickerlb.textColor = .white
        } else {
            startTimeTitleImage.tintColor = UIColor.white.withAlphaComponent(0.7)
            startTimeTitlelb.textColor = UIColor.white.withAlphaComponent(0.7)
            startTimePickerlb.textColor = .white
            
        }
        
    }
    
    
    func endTimeStack(isSelected: Bool) {
        
        if isSelected {
            endTimeTitleImage.tintColor = .systemRed
            endTimeTitlelb.textColor = .systemRed
            endTimePickerlb.textColor = .white
        } else {
            endTimeTitleImage.tintColor = UIColor.white.withAlphaComponent(0.7)
            endTimeTitlelb.textColor = UIColor.white.withAlphaComponent(0.7)
            endTimePickerlb.textColor = .white
            
        }
        
    }
    
    func durTimeStack(isSelected: Bool) {
        
        if isSelected {
            durTimeTitleImage.tintColor = .systemRed
            durTimeTitlelb.textColor = .systemRed
            durTimePickerlb.textColor = .white
        } else {
            durTimeTitleImage.tintColor = UIColor.white.withAlphaComponent(0.7)
            durTimeTitlelb.textColor = UIColor.white.withAlphaComponent(0.7)
            durTimePickerlb.textColor = .white
            
        }
        
    }
    
    func calculateDurTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm aa"
        
        let date1 = dateFormatter.date(from: startTimePickerlb.text!)!
        let date2 = dateFormatter.date(from: endTimePickerlb.text!)!

        let diff = Calendar.current.dateComponents([.hour, .minute], from: date1, to: date2)
        durTimePickerlb.text = "\(diff.hour!) HOUR \(diff.minute!) MINUTE"
    }
    
}
