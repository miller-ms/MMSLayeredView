//
//  SelectColorController.swift
//  MMSBackgroundImage
//
//  Created by William Miller on 5/21/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class SelectColorController: UITableViewController {
    
    let Black = 0
    let DarkGray = 1
    let LightGray = 2
    let White = 3
    let Gray = 4
    let Red = 5
    let Green = 6
    let Blue = 7
    let Cyan = 8
    let Yellow = 9
    let Magenta = 10
    let Orange = 11
    let Purple = 12
    let Brown = 13
    
//    var selectedCell = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0, 0, 0)
        
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
        return 14
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "colorCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ColorCell

        cell.accessoryType = .None

        switch indexPath.row {
        case Black:
            let blackCell = cell
            blackCell.colorView.backgroundColor = UIColor.blackColor()
            
        case DarkGray:
            let darkGrayCell = cell
            darkGrayCell.colorView.backgroundColor = UIColor.orangeColor()

        case LightGray:
            let lightGrayCell = cell
            lightGrayCell.colorView.backgroundColor = UIColor.lightGrayColor()

        case White:
            let whiteCell = cell
            whiteCell.colorView.backgroundColor = UIColor.whiteColor()

        case Gray:
            let grayCell = cell
            grayCell.colorView.backgroundColor = UIColor.grayColor()

        case Red:
            let redCell = cell
            redCell.colorView.backgroundColor = UIColor.redColor()

        case Green:
            let greenCell = cell
            greenCell.colorView.backgroundColor = UIColor.greenColor()

        case Blue:
            let blueCell = cell
            blueCell.colorView.backgroundColor = UIColor.blueColor()

        case Cyan:
            let cyanCell = cell
            cyanCell.colorView.backgroundColor = UIColor.cyanColor()

        case Yellow:
            let yellowCell = cell
            yellowCell.colorView.backgroundColor = UIColor.yellowColor()

        case Magenta:
            let magentaCell = cell
            magentaCell.colorView.backgroundColor = UIColor.magentaColor()

        case Orange:
            let orangeCell = cell
            orangeCell.colorView.backgroundColor = UIColor.orangeColor()

        case Purple:
            let purpleCell = cell
            purpleCell.colorView.backgroundColor = UIColor.purpleColor()

        case Brown:
            let brownCell = cell
            brownCell.colorView.backgroundColor = UIColor.brownColor()
            
        default:
            break
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var selectedColor = UIColor.blackColor()
        
        switch indexPath.row {
            
        case Black:
            selectedColor = UIColor.blackColor()
            break
            
        case DarkGray:
            selectedColor = UIColor.orangeColor()
            
        case LightGray:
            selectedColor = UIColor.lightGrayColor()
            
        case White:
            selectedColor = UIColor.whiteColor()
            
        case Gray:
            selectedColor = UIColor.grayColor()
            
        case Red:
            selectedColor = UIColor.redColor()
            
        case Green:
            selectedColor = UIColor.greenColor()
            
        case Blue:
            selectedColor = UIColor.blueColor()
            
        case Cyan:
            selectedColor = UIColor.cyanColor()
            
        case Yellow:
            selectedColor = UIColor.yellowColor()
            
        case Magenta:
            selectedColor = UIColor.magentaColor()
            
        case Orange:
            selectedColor = UIColor.orangeColor()
            
        case Purple:
            selectedColor = UIColor.purpleColor()
            
        case Brown:
            selectedColor = UIColor.brownColor()
            
        default:
            selectedColor = UIColor.blackColor()
            break
            
        }
        
        let theViewController = presentingViewController as! ViewController

        theViewController.setColor(selectedColor)
        
        dismissViewControllerAnimated(true, completion: nil)

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//    @IBAction func selectColor(sender: UIButton) {
//        
//        let theViewController = presentingViewController as! ViewController
//        
//        var selectedColor = UIColor.blackColor()
//        
//        switch selectedCell {
//        case Black:
//            break
//            
//        case DarkGray:
//            selectedColor = UIColor.orangeColor()
//            
//        case LightGray:
//            selectedColor = UIColor.lightGrayColor()
//            
//        case White:
//            selectedColor = UIColor.whiteColor()
//            
//        case Gray:
//            selectedColor = UIColor.grayColor()
//            
//        case Red:
//            selectedColor = UIColor.redColor()
//            
//        case Green:
//            selectedColor = UIColor.greenColor()
//            
//        case Blue:
//            selectedColor = UIColor.blueColor()
//            
//        case Cyan:
//            selectedColor = UIColor.cyanColor()
//            
//        case Yellow:
//            selectedColor = UIColor.yellowColor()
//            
//        case Magenta:
//            selectedColor = UIColor.magentaColor()
//            
//        case Orange:
//            selectedColor = UIColor.orangeColor()
//            
//        case Purple:
//            selectedColor = UIColor.purpleColor()
//            
//        case Brown:
//            selectedColor = UIColor.brownColor()
//            
//        default:
//            break
//            
//        }
//        
//        theViewController.setColor(selectedColor)
//        
//        dismissViewControllerAnimated(true, completion: nil)
//
//        
//    }
    
}
