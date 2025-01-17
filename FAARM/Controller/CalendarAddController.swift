//
//  DetailsController.swift
//  FAARM
//
//  Created by Christopher Villanueva on 4/18/18.
//  Copyright © 2018 Christopher Villanueva. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class CalendarAddController: UIViewController {
    
    let detailsView: UIView = {
        let view = UIView()
        view.backgroundColor = .ucmBlue
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.backgroundColor = .ucmGold
        button.titleLabel?.textColor = .white
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.backgroundColor = .ucmGold
        button.titleLabel?.textColor = .white
        button.setTitle("Add", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        button.backgroundColor = .ucmGold
        button.titleLabel?.textColor = .white
        button.setTitle("Delete", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let buttonsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .ucmGold
        return label
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .ucmBlue
        textView.textColor = .white
        textView.textAlignment = .left
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.systemFont(ofSize: 20)
        
        let model = UIDevice.current.model
        
        if (model != "iPhone" && model != "iPod"){
            textView.font = UIFont.systemFont(ofSize: 30)
        }
        
        return textView
    }()
    
    var timeInterval: Int?
    var monthAbbrev: String?
    var dayNumber: String?
    var dayName: String?
    var year: String?
    var id: String?
    
    var calendarController: CalendarController?
    
    var indexPath: IndexPath?
    
    var calendarEvent: CalendarEvent? {
        didSet {
            if let dayName = calendarEvent?.dayName, let monthAbbrev = calendarEvent?.monthAbbrev, let dayNumber = calendarEvent?.dayNumber, let year = calendarEvent?.year {
                let attributedText = NSMutableAttributedString(string: "Date : ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.white])
                attributedText.append(NSAttributedString(string: "\(dayName), \(monthAbbrev) \(dayNumber)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.white]))
                dateLabel.attributedText = attributedText
                
                let idString = calendarEvent?.id
                
                self.monthAbbrev = monthAbbrev
                self.dayNumber = dayNumber
                self.dayName = dayName
                self.year = year
                self.id = idString
            }
            descriptionTextView.text = calendarEvent?.name
            timeInterval = calendarEvent?.timeInterval
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
   
}




