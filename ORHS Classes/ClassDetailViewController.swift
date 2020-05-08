//
//  ClassDetailViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 5/30/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController {

    //MARK: Properties
    var course: Class?
    var subject: String? //passed from classTableView
    @IBOutlet weak var GPALabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var descriptionTextBox: UITextView!
    @IBOutlet weak var AddButton: UIBarButtonItem!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for schedules in YearTableViewController.schedules {
            for classes in schedules {
                if (classes.name == course!.name) {
                    AddButton.isEnabled = false
                    course?.added = true
                    return
                }
            }
        }
        AddButton.isEnabled = true
        course?.added = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = course?.name
        GPALabel.text = "GPA: \(course!.GPA)"
        creditLabel.text = "Credits: \(course!.credits)"
        hourLabel.text = "Homework: \(course!.hours) hrs/day"
        descriptionTextBox.text = course!.description
        categoryLabel.text = "Subject: \(course!.subject)"
        
        if course!.added {
            AddButton.isEnabled = false
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
            fatalError("Unexpected deestination")
        }
        let Year = Navigation.topViewController as! AddYearTableViewController
        Year.tempCourse = course!
        default: fatalError("Unexpected Segue Identifier")
        }
        
    }
    
    @IBAction func unwindToVC1(sender:UIStoryboardSegue) {
        if sender.identifier == "SaveClass" {
            course!.added = true
            AddButton.isEnabled = false
            print("added " + course!.name)
            print(course!.credits)
            ChecklistTableViewController.edit(course!, true) //passes course on to edit checklist
           
        }
        else {
        }
    }

   
    

}
