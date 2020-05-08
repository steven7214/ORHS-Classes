//
//  ChecklistTableViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 6/3/19.
//  Copyright © 2019 Steven QU. All rights reserved.
//

import UIKit

class ChecklistTableViewController: UITableViewController {

   
    //MARK: properties
    static let requirements = [("English", 4.0), ("Math", 4.0), ("Science", 3.0), ("World Language", 2.0), ("Fine Art", 1.0), ("U.S. History", 1.0), ("History/Geography", 1.0), ("Economics", 0.5), ("Government", 0.5), ("Personal Finance", 0.5), ("Lifetime Wellness", 1.5)]
    static var current = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ChecklistTableViewController.requirements.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "requirementCell", for: indexPath) as? ChecklistTableViewCell else {
            fatalError("The dequeued cell is not an instance of requirementCell")
        }
        let num = indexPath.row
        cell.textLabel?.text = ChecklistTableViewController.requirements[num].0 //puts name of requirement
        if(ChecklistTableViewController.current[num] >= ChecklistTableViewController.requirements[num].1) {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }
        cell.completionLabel.textAlignment = .center
        var temp = ChecklistTableViewController.current[num]
        if (temp > ChecklistTableViewController.requirements[num].1) {
            temp = ChecklistTableViewController.requirements[num].1 //makes sure checklist doesn't go above 100% done
        }
        cell.completionLabel.text = "(\(temp)/\(ChecklistTableViewController.requirements[num].1))" //keeps track of how many completed in a box

        return cell
    }
    
    //edits the checklist
    static func edit(_ course:Class, _ add:Bool) {
        //this is wrong we need the real graduation credit subject fix later
        let index = convert(course.subject)
        
        if (add == false){
            ChecklistTableViewController.current[index] -= Double(course.credits)!
        }
        else {
            ChecklistTableViewController.current[index] += Double(course.credits)!  
        }
        
    }
    
    
    static func convert(_ oldNum:String) -> Int{
        var num = -1
        var index = 0
        for tuples in requirements{
            if (oldNum == tuples.0) {
                num = index
                break
            }
            index += 1
        }
        if (num < 0) {
            print("subject not found")
        }
        print("num\(num)")
        return num
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //attempted to restore state
//    override func encodeRestorableState(with coder: NSCoder) {
//        coder.encode(ChecklistTableViewController.current, forKey: "credits")
//        super.encodeRestorableState(with: coder)
//    }
//
//    override func decodeRestorableState(with coder: NSCoder) {
//        ChecklistTableViewController.current = coder.decodeObject(forKey: "credits") as! [Double]
//        super.decodeRestorableState(with: coder)
//    }
//
//    override func applicationFinishedRestoringState() {
//
//    }
}
