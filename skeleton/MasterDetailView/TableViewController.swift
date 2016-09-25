//
//  TableViewController.swift
//  MasterDetailView
//
//  Created by lnz on 9/24/16.
//  Copyright © 2016 CS2048 Instructor. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //var functionsDB = ["x", "x**2", "x**3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Subscribe to notifications from our model
        NSNotificationCenter.defaultCenter().addObserverForName("FUNCTIONS_DB_CHANGED",
                                                         object: FunctionDB.sharedInstance,
                                                         queue: nil){
            (NSNotificationCenter) in self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FunctionDB.sharedInstance.functions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("functionCellReusableID", forIndexPath: indexPath) as! TableViewCell
        
        // indexPath.section <- in case you have multiple sections
        
        // The basic UITableViewCell has two labels (although the detailTextLabel
        // doesn't show up in the basic style)
        //cell.detailTextLabel?.text = FunctionDB.sharedInstance.functions[indexPath.row]
        cell.functionLabel.text = FunctionDB.sharedInstance.functions[indexPath.row]
        //cell.textLabel?.text = "f(x) ="
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get the new view controller using segue.destinationViewController.
        //Pass the selected object to the new view controller.
        
        // segue.identifier
        
        let dst = segue.destinationViewController as! FunctionPlottingViewController
        let cell = sender as! TableViewCell
        
        dst.expressionFromSegue = cell.functionLabel.text!
        dst.expressionIdxFromSegue = tableView.indexPathForCell(cell)?.row
        
    }

}
