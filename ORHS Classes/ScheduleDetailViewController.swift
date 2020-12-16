//
//  ClassDetailViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 5/30/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController {
    //static var dialog = false
    //MARK: Properties
    var course: Class?
    var subject: String? //passed from classTableView
    @IBOutlet weak var GPALabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var hourLabel: UITextView!
    @IBOutlet weak var descriptionTextBox: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var AddButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for schedules in YearTableViewController.schedules {
            for classes in schedules {
                if (classes.name == course!.name) {
                    // AddButton.isEnabled = false
                    course?.added = true
                    return
                }
            }
        }
        //AddButton.isEnabled = true
        course?.added = false
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = course?.name
        GPALabel.text = "GPA: \(course!.GPA)"
        creditLabel.text = "Credits: \(course!.credits)"
        hourLabel.text = "Prerequisites: \(course!.hours)"
        descriptionTextBox.text = course!.summary
        categoryLabel.text = "Subject: \(course!.subject)"
        hourLabel.sizeToFit()
        categoryLabel.sizeToFit()
        categoryLabel.frame.origin = CGPoint(x: 250, y: 95)
        categoryLabel.numberOfLines = 0
        let numLines = (Int(hourLabel.contentSize.height) / Int(hourLabel.font!.lineHeight)) - 1
        if numLines <= 3 {
            hourLabel.frame.origin = CGPoint(x: 0, y: 88)
            GPALabel.frame.origin = CGPoint(x: 250, y: 120)
            creditLabel.frame.origin = CGPoint(x: 5, y: 120)
            descriptionTextBox.frame.origin = CGPoint(x: 0, y: 194)
        }
        if numLines > 3 {
            if (course?.subject) == "Personal Finance" || (course?.subject) == "U.S. Government" || (course?.subject) == "World Languages" || (course?.subject) == "Career Academies" || (course?.subject) == "World History/Geography" {
                hourLabel.frame.origin = CGPoint(x: 0, y: 88)
                creditLabel.frame.origin = CGPoint(x: 250, y: ((hourLabel.font!.lineHeight * CGFloat(numLines-3) + 88) + 88)/2)
                GPALabel.frame.origin = CGPoint(x: 250, y: hourLabel.font!.lineHeight * CGFloat(numLines-3) + 98)
                descriptionTextBox.frame.origin = CGPoint(x: 0, y: hourLabel.font!.lineHeight * CGFloat(numLines-2)+150)
            }
            else {
                hourLabel.frame.origin = CGPoint(x: 0, y: 88)
                creditLabel.frame.origin = CGPoint(x: 250, y: ((hourLabel.font!.lineHeight * CGFloat(numLines-4) + 88) + 88)/2)
                GPALabel.frame.origin = CGPoint(x: 250, y: hourLabel.font!.lineHeight * CGFloat(numLines-3) + 98)
                descriptionTextBox.frame.origin = CGPoint(x: 0, y: hourLabel.font!.lineHeight * CGFloat(numLines-2)+150)
            }
        }
        if (course?.subject) == "Personal Finance" {
            
            categoryLabel.text = "Subject: Personal \n" + "Finance"
            categoryLabel.sizeToFit()
        }
        if (course?.subject) == "U.S. Government" {
            
            categoryLabel.text = "Subject: U.S. \n" + "Government"
            categoryLabel.sizeToFit()
        }
        if (course?.subject) == "World Languages" {
            
            categoryLabel.text = "Subject: World \n" + "Languages"
            categoryLabel.sizeToFit()
        }
        if (course?.subject) == "Career Academies" {
            
            categoryLabel.text = "Subject: Career \n" + "Academies"
            categoryLabel.sizeToFit()
        }
        if (course?.subject) == "World History/Geography" {
            
            categoryLabel.text = "Subject: World History/ \n" + "Geography"
            categoryLabel.sizeToFit()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "ChooseYear": guard let Navigation = segue.destination as? UINavigationController else {
            fatalError("Unexpected destination")
        }
        let Year = Navigation.topViewController as! AddYearTableViewController
        Year.tempCourse = self.course!
        default: fatalError("Unexpected Segue Identifier")
        }
    }
    
    @IBAction func unwindToVC1(sender:UIStoryboardSegue) {
        if subject == "Other" {
            if sender.identifier == "SaveClass" {
                course!.added = true
                //AddButton.isEnabled = false
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: YearTableViewController.schedules)
                UserDefaults.standard.set(encodedData, forKey: "savedSchedules")
                return
            }
        }
        if subject == "Career Academies" {
            if sender.identifier == "SaveClass" {
                course!.added = true
                //AddButton.isEnabled = false
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: YearTableViewController.schedules)
                UserDefaults.standard.set(encodedData, forKey: "savedSchedules")
                return
            }
        }
        if sender.identifier == "SaveClass" {
            course!.added = true
            //AddButton.isEnabled = false
            print("added " + course!.name)
            print(course!.credits)
            ChecklistTableViewController.edit(course!, true) //passes course on to edit checklist
           
        }
        else {
        }
    }

   
    

}
