//
//  TimeAndReccurenceController.swift
//  MySquadPro
//
//  Created by Bhargin Kanani on 3/18/21.
//

import UIKit
import DateTimePicker

class TimeAndReccurenceController: UIViewController {
    
    var selectedTag: Int = 1
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Edit Your Schedule"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let repeatTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Days Active"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let repeatBackground: UIView = {
        let bg = UIView(frame: .zero)
        bg.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        bg.layer.cornerRadius = 10
        bg.layer.masksToBounds = true
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    
    let timePickerBackground: UIView = {
        let bg = UIView(frame: .zero)
        bg.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        bg.layer.cornerRadius = 10
        bg.layer.masksToBounds = true
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    let timePickerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Start and End Time"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let startTimeTitleImage = UIImageView()
    let startTimeTitlelb = UILabel()
    let startTimePickerlb = UILabel()
    
    
    let endTimeTitleImage = UIImageView()
    let endTimeTitlelb = UILabel()
    let endTimePickerlb = UILabel()
    
    let durTimeTitleImage = UIImageView()
    let durTimeTitlelb = UILabel()
    let durTimePickerlb = UILabel()
    
    let picker = UIDatePicker(frame: .zero)
    
    var recognizer: UITapGestureRecognizer {
        get {
            return UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleBack))
        self.navigationItem.leftBarButtonItem!.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], for: UIControl.State.normal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20,weight: .bold)], for: UIControl.State.normal)
        
        
        view.backgroundColor = #colorLiteral(red: 0.1490017474, green: 0.1529527605, blue: 0.1764442623, alpha: 1)
        
        
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/17).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        
        view.addSubview(repeatTitleLabel)
        repeatTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        repeatTitleLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1/2).isActive = true
        repeatTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        repeatTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        
        view.addSubview(repeatBackground)
        repeatBackground.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        repeatBackground.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 10).isActive = true
        repeatBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        repeatBackground.topAnchor.constraint(equalTo: repeatTitleLabel.bottomAnchor, constant: 15).isActive = true
        repeatBackground.leftAnchor.constraint(equalTo: repeatTitleLabel.leftAnchor).isActive = true
        
        let monView = UIView()
        monView.backgroundColor = UIColor.clear
        monView.tag = 1
        monView.layer.cornerRadius = 20
        monView.addGestureRecognizer(recognizer)
        monView.layer.masksToBounds = true
        
        let monlb = UILabel()
        monlb.text = "M"
        monlb.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        monlb.textColor = .white
        monlb.textAlignment = .center
        monlb.translatesAutoresizingMaskIntoConstraints = false
        monView.addSubview(monlb)
        
        let tueView = UIView()
        tueView.backgroundColor = UIColor.clear
        tueView.tag = 2
        tueView.layer.cornerRadius = 20
        tueView.addGestureRecognizer(recognizer)
        tueView.layer.masksToBounds = true
        
        let tuelb = UILabel()
        tuelb.text = "T"
        tuelb.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        tuelb.textColor = .white
        tuelb.textAlignment = .center
        tuelb.translatesAutoresizingMaskIntoConstraints = false
        tueView.addSubview(tuelb)
        
        let wedView = UIView()
        wedView.backgroundColor = UIColor.clear
        wedView.tag = 3
        wedView.layer.cornerRadius = 20
        wedView.addGestureRecognizer(recognizer)
        wedView.layer.masksToBounds = true
        
        let wedlb = UILabel()
        wedlb.text = "W"
        wedlb.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        wedlb.textColor = .white
        wedlb.textAlignment = .center
        wedlb.translatesAutoresizingMaskIntoConstraints = false
        wedView.addSubview(wedlb)
        
        let thuView = UIView()
        thuView.backgroundColor = UIColor.clear
        thuView.tag = 4
        thuView.layer.cornerRadius = 20
        thuView.addGestureRecognizer(recognizer)
        thuView.layer.masksToBounds = true
        
        let thulb = UILabel()
        thulb.text = "T"
        thulb.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        thulb.textColor = .white
        thulb.textAlignment = .center
        thulb.translatesAutoresizingMaskIntoConstraints = false
        thuView.addSubview(thulb)
        
        let friView = UIView()
        friView.backgroundColor = UIColor.clear
        friView.tag = 5
        friView.layer.cornerRadius = 20
        friView.addGestureRecognizer(recognizer)
        friView.layer.masksToBounds = true
        
        let frilb = UILabel()
        frilb.text = "F"
        frilb.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        frilb.textColor = .white
        frilb.textAlignment = .center
        frilb.translatesAutoresizingMaskIntoConstraints = false
        friView.addSubview(frilb)
        
        let satView = UIView()
        satView.backgroundColor = UIColor.clear
        satView.tag = 6
        satView.layer.cornerRadius = 20
        satView.addGestureRecognizer(recognizer)
        satView.layer.masksToBounds = true
        
        let satlb = UILabel()
        satlb.text = "S"
        satlb.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        satlb.textColor = .white
        satlb.textAlignment = .center
        satlb.translatesAutoresizingMaskIntoConstraints = false
        satView.addSubview(satlb)
        
        let sunView = UIView()
        sunView.backgroundColor = UIColor.clear
        sunView.tag = 7
        sunView.layer.cornerRadius = 20
        sunView.addGestureRecognizer(recognizer)
        sunView.layer.masksToBounds = true
        
        let sunlb = UILabel()
        sunlb.text = "S"
        sunlb.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        sunlb.textColor = .white
        sunlb.textAlignment = .center
        sunlb.translatesAutoresizingMaskIntoConstraints = false
        sunView.addSubview(sunlb)
        
        let stackView = UIStackView(arrangedSubviews: [monView, tueView, wedView, thuView, friView, satView, sunView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        
        repeatBackground.addSubview(stackView)
       
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: repeatBackground.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: repeatBackground.centerXAnchor),
            stackView.heightAnchor.constraint(equalTo: repeatBackground.heightAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: repeatBackground.widthAnchor, constant: -20),
            
            monlb.centerXAnchor.constraint(equalTo: monView.centerXAnchor),
            monlb.centerYAnchor.constraint(equalTo: monView.centerYAnchor),
            monlb.widthAnchor.constraint(equalTo: monView.widthAnchor),
            monlb.heightAnchor.constraint(equalTo: monView.heightAnchor),
            
            tuelb.centerXAnchor.constraint(equalTo: tueView.centerXAnchor),
            tuelb.centerYAnchor.constraint(equalTo: tueView.centerYAnchor),
            tuelb.widthAnchor.constraint(equalTo: tueView.widthAnchor),
            tuelb.heightAnchor.constraint(equalTo: tueView.heightAnchor),
            
            wedlb.centerXAnchor.constraint(equalTo: wedView.centerXAnchor),
            wedlb.centerYAnchor.constraint(equalTo: wedView.centerYAnchor),
            wedlb.widthAnchor.constraint(equalTo: wedView.widthAnchor),
            wedlb.heightAnchor.constraint(equalTo: wedView.heightAnchor),
            
            thulb.centerXAnchor.constraint(equalTo: thuView.centerXAnchor),
            thulb.centerYAnchor.constraint(equalTo: thuView.centerYAnchor),
            thulb.widthAnchor.constraint(equalTo: thuView.widthAnchor),
            thulb.heightAnchor.constraint(equalTo: thuView.heightAnchor),
            
            frilb.centerXAnchor.constraint(equalTo: friView.centerXAnchor),
            frilb.centerYAnchor.constraint(equalTo: friView.centerYAnchor),
            frilb.widthAnchor.constraint(equalTo: friView.widthAnchor),
            frilb.heightAnchor.constraint(equalTo: friView.heightAnchor),
            
            satlb.centerXAnchor.constraint(equalTo: satView.centerXAnchor),
            satlb.centerYAnchor.constraint(equalTo: satView.centerYAnchor),
            satlb.widthAnchor.constraint(equalTo: satView.widthAnchor),
            satlb.heightAnchor.constraint(equalTo: satView.heightAnchor),
            
            sunlb.centerXAnchor.constraint(equalTo: sunView.centerXAnchor),
            sunlb.centerYAnchor.constraint(equalTo: sunView.centerYAnchor),
            sunlb.widthAnchor.constraint(equalTo: sunView.widthAnchor),
            sunlb.heightAnchor.constraint(equalTo: sunView.heightAnchor)
        ])
        
        
        
        view.addSubview(timePickerLabel)
        timePickerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3).isActive = true
        timePickerLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1/2).isActive = true
        timePickerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        timePickerLabel.topAnchor.constraint(equalTo: repeatBackground.bottomAnchor, constant: 40).isActive = true
        
        
        view.addSubview(timePickerBackground)
        timePickerBackground.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        timePickerBackground.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2, constant: -40).isActive = true
        timePickerBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timePickerBackground.topAnchor.constraint(equalTo: timePickerLabel.bottomAnchor, constant: 15).isActive = true
        timePickerBackground.leftAnchor.constraint(equalTo: timePickerLabel.leftAnchor).isActive = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm aa"
        
        picker.datePickerMode = .time
        picker.tintColor = .white
        picker.preferredDatePickerStyle = .wheels
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        picker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        //MARK: START TIME STACK
        
        let startTimeStack = UIStackView()
        startTimeStack.axis = .vertical
        startTimeStack.distribution = .fillEqually
        startTimeStack.tag = 1
        startTimeStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.timeLabelTapped(_:))))
        startTimeStack.translatesAutoresizingMaskIntoConstraints = false
        
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.distribution = .fill
        hstack.spacing = 10
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        
        // CONFIG START TIME STACK VIEWS
        startTimeTitleImage.image = UIImage(systemName: "bell.fill")
        startTimeTitleImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        startTimeTitlelb.text = "START"
        startTimeTitlelb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        startTimeTitlelb.textAlignment = .center
        startTimeTitlelb.translatesAutoresizingMaskIntoConstraints = false
        
        
        startTimePickerlb.text = dateFormatter.string(from: picker.date)
        startTimePickerlb.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        startTimePickerlb.textAlignment = .right
        startTimePickerlb.translatesAutoresizingMaskIntoConstraints = false
        
        
        // ADD ALL SUBVIEWS TO START TIME STACK
        timePickerBackground.addSubview(startTimeStack)
        startTimeStack.addArrangedSubview(hstack)
        hstack.addArrangedSubview(startTimeTitleImage)
        hstack.addArrangedSubview(startTimeTitlelb)
        startTimeStack.addSubview(startTimePickerlb)
        
        
        // START TIME STACK CONSTRAINTS
        NSLayoutConstraint.activate([
            startTimeStack.rightAnchor.constraint(equalTo: timePickerBackground.centerXAnchor, constant: -60),
            startTimeStack.heightAnchor.constraint(equalTo: repeatBackground.heightAnchor, constant: 5),
            startTimeStack.widthAnchor.constraint(equalTo: repeatBackground.widthAnchor, multiplier: 1/2, constant: -30),
            startTimeStack.topAnchor.constraint(equalTo: timePickerBackground.topAnchor, constant: 15),
            
            hstack.widthAnchor.constraint(equalTo: startTimeStack.widthAnchor),
            hstack.heightAnchor.constraint(equalTo: startTimeStack.heightAnchor, multiplier: 1/3),
            hstack.leftAnchor.constraint(equalTo: startTimeStack.leftAnchor),
            hstack.topAnchor.constraint(equalTo: startTimeStack.topAnchor),
            
            
            startTimeTitleImage.heightAnchor.constraint(equalTo: hstack.heightAnchor, constant: -2),
            startTimeTitleImage.widthAnchor.constraint(equalTo: hstack.widthAnchor, multiplier: 1/8),
            startTimeTitleImage.rightAnchor.constraint(equalTo: hstack.centerXAnchor, constant: 10),
            
            
            startTimeTitlelb.heightAnchor.constraint(equalTo: hstack.heightAnchor),
            startTimeTitlelb.widthAnchor.constraint(equalTo: hstack.widthAnchor, multiplier: 2/4),
            startTimeTitlelb.leftAnchor.constraint(equalTo: hstack.centerXAnchor),
            startTimeTitlelb.centerYAnchor.constraint(equalTo: startTimeTitleImage.centerYAnchor),
            

            startTimePickerlb.widthAnchor.constraint(equalTo: startTimeStack.widthAnchor),
            startTimePickerlb.centerXAnchor.constraint(equalTo: hstack.centerXAnchor),
            startTimePickerlb.heightAnchor.constraint(equalTo: startTimeStack.heightAnchor, multiplier: 2/3),
            startTimePickerlb.topAnchor.constraint(equalTo: hstack.bottomAnchor, constant: -5)
        ])
        
        self.startTimeStack(isSelected: true)
        
        
        
        //MARK: END TIME STACK
        
        let endTimeStack = UIStackView()
        endTimeStack.axis = .vertical
        endTimeStack.distribution = .fillEqually
        endTimeStack.tag = 2
        endTimeStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.timeLabelTapped(_:))))
        endTimeStack.translatesAutoresizingMaskIntoConstraints = false
        
        let hstack2 = UIStackView()
        hstack2.axis = .horizontal
        hstack2.distribution = .fill
        hstack2.spacing = 10
        hstack2.translatesAutoresizingMaskIntoConstraints = false
        
        
        // CONFIG END TIME STACK VIEWS
        endTimeTitleImage.image = UIImage(systemName: "bell.slash.fill")
        endTimeTitleImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        endTimeTitlelb.text = "END"
        endTimeTitlelb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        endTimeTitlelb.textAlignment = .center
        endTimeTitlelb.translatesAutoresizingMaskIntoConstraints = false
        
        
        endTimePickerlb.text = dateFormatter.string(from: picker.date.advanced(by: 60*60))
        endTimePickerlb.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        endTimePickerlb.textAlignment = .right
        endTimePickerlb.translatesAutoresizingMaskIntoConstraints = false
        
        
        // ADD ALL SUBVIEWS TO END TIME STACK
        timePickerBackground.addSubview(endTimeStack)
        endTimeStack.addArrangedSubview(hstack2)
        hstack2.addArrangedSubview(endTimeTitleImage)
        hstack2.addArrangedSubview(endTimeTitlelb)
        endTimeStack.addSubview(endTimePickerlb)
        
        
        // END TIME STACK CONSTRAINTS
        NSLayoutConstraint.activate([
            endTimeStack.leftAnchor.constraint(equalTo: timePickerBackground.centerXAnchor, constant: 0),
            endTimeStack.heightAnchor.constraint(equalTo: repeatBackground.heightAnchor, constant: 5),
            endTimeStack.widthAnchor.constraint(equalTo: repeatBackground.widthAnchor, multiplier: 1/2, constant: -30),
            endTimeStack.topAnchor.constraint(equalTo: timePickerBackground.topAnchor, constant: 15),
            
            
            hstack2.widthAnchor.constraint(equalTo: endTimeStack.widthAnchor),
            hstack2.heightAnchor.constraint(equalTo: endTimeStack.heightAnchor, multiplier: 1/3),
            hstack2.leftAnchor.constraint(equalTo: endTimeStack.leftAnchor),
            hstack2.topAnchor.constraint(equalTo: endTimeStack.topAnchor),
            
            
            endTimeTitleImage.heightAnchor.constraint(equalTo: hstack2.heightAnchor, constant: -2),
            endTimeTitleImage.widthAnchor.constraint(equalTo: hstack2.widthAnchor, multiplier: 1/8),
            endTimeTitleImage.leftAnchor.constraint(equalTo: hstack2.centerXAnchor),
            
            
            
            endTimeTitlelb.heightAnchor.constraint(equalTo: hstack2.heightAnchor),
            endTimeTitlelb.widthAnchor.constraint(equalTo: hstack2.widthAnchor, multiplier: 2/4),
            endTimeTitlelb.leftAnchor.constraint(equalTo: endTimeTitleImage.centerXAnchor),
            endTimeTitlelb.centerYAnchor.constraint(equalTo: endTimeTitleImage.centerYAnchor),
            
            
            endTimePickerlb.widthAnchor.constraint(equalTo: endTimeStack.widthAnchor),
            endTimePickerlb.centerXAnchor.constraint(equalTo: hstack2.centerXAnchor),
            endTimePickerlb.heightAnchor.constraint(equalTo: endTimeStack.heightAnchor, multiplier: 2/3),
            endTimePickerlb.topAnchor.constraint(equalTo: hstack2.bottomAnchor, constant: -5)
        ])
    
        self.endTimeStack(isSelected: false)
        
        
        
        //MARK: TIME PICKER WHEEL
        
        // CONFIG TIME PICKER WHEEL BACKGROUND VIEW
        let whiteBackground = UIView(frame: .zero)
        whiteBackground.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        whiteBackground.layer.cornerRadius = 10
        whiteBackground.layer.masksToBounds = true
        whiteBackground.translatesAutoresizingMaskIntoConstraints = false
        
        
        // TIME PICKER WHEEL BACKGROUND VIEW CONSTRAINT
        timePickerBackground.addSubview(whiteBackground)
        whiteBackground.widthAnchor.constraint(equalTo: timePickerBackground.widthAnchor, constant: -50).isActive = true
        whiteBackground.heightAnchor.constraint(equalTo: timePickerBackground.heightAnchor, multiplier: 1/3).isActive = true
        whiteBackground.centerXAnchor.constraint(equalTo: timePickerBackground.centerXAnchor).isActive = true
        whiteBackground.topAnchor.constraint(equalTo: endTimeStack.bottomAnchor, constant: 20).isActive = true
        
        
        // TIME PICKER WHEEL CONSTRAINT
        whiteBackground.addSubview(picker)
        picker.widthAnchor.constraint(equalTo: whiteBackground.widthAnchor).isActive = true
        picker.heightAnchor.constraint(equalTo: whiteBackground.heightAnchor).isActive = true
        picker.centerXAnchor.constraint(equalTo: whiteBackground.centerXAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: whiteBackground.centerYAnchor).isActive = true
        
        
        
        
        // MARK: DURATION TIME STACK
        
        let durTimeStack = UIStackView()
        durTimeStack.axis = .vertical
        durTimeStack.distribution = .fillEqually
        durTimeStack.tag = 2
        durTimeStack.translatesAutoresizingMaskIntoConstraints = false
        
        let hstack3 = UIStackView()
        hstack3.axis = .horizontal
        hstack3.distribution = .fill
        hstack3.backgroundColor = .green
        hstack3.translatesAutoresizingMaskIntoConstraints = false
        
        
        // CONFIG DURATION TIME STACK VIEWS
        durTimeTitleImage.image = UIImage(systemName: "timer")
        durTimeTitleImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        durTimeTitlelb.text = "DURATION"
        durTimeTitlelb.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        durTimeTitlelb.translatesAutoresizingMaskIntoConstraints = false
        
        
        durTimePickerlb.text = dateFormatter.string(from: picker.date.advanced(by: 60*60))
        durTimePickerlb.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        durTimePickerlb.textAlignment = .center
        durTimePickerlb.text = "1 HOUR 15 MINUTES"
        durTimePickerlb.translatesAutoresizingMaskIntoConstraints = false
        
        
        // ADD ALL SUBVIEWS TO DURATION TIME STACK
        timePickerBackground.addSubview(durTimeStack)
        timePickerBackground.addSubview(hstack3)
        timePickerBackground.addSubview(durTimeTitleImage)
        timePickerBackground.addSubview(durTimeTitlelb)
        timePickerBackground.addSubview(durTimePickerlb)
        
        
        // DURATION TIME STACK CONSTRAINTS
        NSLayoutConstraint.activate([
            durTimeStack.centerXAnchor.constraint(equalTo: timePickerBackground.centerXAnchor, constant: 0),
            durTimeStack.heightAnchor.constraint(equalTo: whiteBackground.heightAnchor, multiplier: 3/4),
            durTimeStack.widthAnchor.constraint(equalTo: whiteBackground.widthAnchor, constant: -40),
            durTimeStack.topAnchor.constraint(equalTo: whiteBackground.bottomAnchor, constant: 45),
            
            durTimeTitlelb.topAnchor.constraint(equalTo: durTimeStack.topAnchor),
            durTimeTitlelb.widthAnchor.constraint(equalTo: durTimeStack.widthAnchor, multiplier: 1/2, constant: -5),
            durTimeTitlelb.heightAnchor.constraint(equalTo: durTimeStack.heightAnchor, multiplier: 1/2, constant: -10),
            durTimeTitlelb.centerXAnchor.constraint(equalTo: whiteBackground.centerXAnchor, constant: 25),
            
            durTimeTitleImage.widthAnchor.constraint(equalTo: durTimeStack.widthAnchor, multiplier: 1/10),
            durTimeTitleImage.heightAnchor.constraint(equalTo: durTimeStack.heightAnchor, multiplier: 1/2, constant: -20),
            durTimeTitleImage.rightAnchor.constraint(equalTo: durTimeTitlelb.leftAnchor, constant: -5),
            durTimeTitleImage.centerYAnchor.constraint(equalTo: durTimeTitlelb.centerYAnchor),
            
            durTimePickerlb.widthAnchor.constraint(equalTo: durTimeStack.widthAnchor),
            durTimePickerlb.heightAnchor.constraint(equalTo: durTimeStack.heightAnchor, multiplier: 1/2),
            durTimePickerlb.centerXAnchor.constraint(equalTo: durTimeStack.centerXAnchor),
            durTimePickerlb.topAnchor.constraint(equalTo: durTimeTitlelb.bottomAnchor, constant: -10)
            
        ])
        
        self.durTimeStack(isSelected: false)
        self.calculateDurTime()
        
    }
    
    
    
    
    
}
