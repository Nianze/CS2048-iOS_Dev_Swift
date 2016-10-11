//
//  TableViewController.swift
//  MasterDetailView
//
//  Created by Daniel Hauagge on 9/24/16.
//  Copyright © 2016 CS2048 Instructor. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    // var functionsDB = ["x", "x**2", "x**3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // Subscribe to notifications from our model
    NSNotificationCenter.defaultCenter().addObserverForName("FUNCTIONS_DB_CHANGED", object:FunctionsDB.sharedInstance, queue: nil){
            (NSNotification) in
            self.tableView.reloadData()
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
        return FunctionsDB.sharedInstance.functions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("functionCellReusableID", forIndexPath: indexPath) as! TableViewCell

        // indexPath.section <- in case you have multiple sections
        
        // The basic UITableViewCell has two labels (although the detailTextLabel 
        // doesn't show up in the basic style)
        cell.functionLabel.text = FunctionsDB.sharedInstance.functions[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44.0)
    }
    
    // table header
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int)-> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
        // add button
        let button = UIButton(frame:CGRect(x: 260, y: 20, width: 22, height: 22))
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderColor = UIColor(red:0.0/255.0, green:122.0/255.0, blue:255.0/255.0, alpha:1).CGColor as CGColorRef
        button.layer.borderWidth = 1.0
        button.setTitle("+", forState: .Normal)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addNewFunctionPressed), forControlEvents: .TouchUpInside)
        headerCell.addSubview(button)
        return headerCell
    }
    
    func addNewFunctionPressed(sender: UIButton!) {
        print("Button tapped")
    }

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // sender: in our case the table view cell that was clicked
        
        // segue.identifier
        
        let dst = segue.destinationViewController as! FunctionPlottingViewController
        let cell = sender as! TableViewCell
        
        dst.expressionFromSegue = cell.functionLabel.text!
        dst.expressionIdxFromSegue = tableView.indexPathForCell(cell)?.row
    }
    
    // delete operation
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            FunctionsDB.sharedInstance.functions.removeAtIndex(indexPath.row)
        }
    }
}
