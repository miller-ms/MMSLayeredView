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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 14
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "colorCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ColorCell

        cell.accessoryType = .none

        switch indexPath.row {
        case Black:
            let blackCell = cell
            blackCell.colorView.backgroundColor = UIColor.black
            
        case DarkGray:
            let darkGrayCell = cell
            darkGrayCell.colorView.backgroundColor = UIColor.orange

        case LightGray:
            let lightGrayCell = cell
            lightGrayCell.colorView.backgroundColor = UIColor.lightGray

        case White:
            let whiteCell = cell
            whiteCell.colorView.backgroundColor = UIColor.white

        case Gray:
            let grayCell = cell
            grayCell.colorView.backgroundColor = UIColor.gray

        case Red:
            let redCell = cell
            redCell.colorView.backgroundColor = UIColor.red

        case Green:
            let greenCell = cell
            greenCell.colorView.backgroundColor = UIColor.green

        case Blue:
            let blueCell = cell
            blueCell.colorView.backgroundColor = UIColor.blue

        case Cyan:
            let cyanCell = cell
            cyanCell.colorView.backgroundColor = UIColor.cyan

        case Yellow:
            let yellowCell = cell
            yellowCell.colorView.backgroundColor = UIColor.yellow

        case Magenta:
            let magentaCell = cell
            magentaCell.colorView.backgroundColor = UIColor.magenta

        case Orange:
            let orangeCell = cell
            orangeCell.colorView.backgroundColor = UIColor.orange

        case Purple:
            let purpleCell = cell
            purpleCell.colorView.backgroundColor = UIColor.purple

        case Brown:
            let brownCell = cell
            brownCell.colorView.backgroundColor = UIColor.brown
            
        default:
            break
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedColor = UIColor.black
        
        switch indexPath.row {
            
        case Black:
            selectedColor = UIColor.black
            break
            
        case DarkGray:
            selectedColor = UIColor.orange
            
        case LightGray:
            selectedColor = UIColor.lightGray
            
        case White:
            selectedColor = UIColor.white
            
        case Gray:
            selectedColor = UIColor.gray
            
        case Red:
            selectedColor = UIColor.red
            
        case Green:
            selectedColor = UIColor.green
            
        case Blue:
            selectedColor = UIColor.blue
            
        case Cyan:
            selectedColor = UIColor.cyan
            
        case Yellow:
            selectedColor = UIColor.yellow
            
        case Magenta:
            selectedColor = UIColor.magenta
            
        case Orange:
            selectedColor = UIColor.orange
            
        case Purple:
            selectedColor = UIColor.purple
            
        case Brown:
            selectedColor = UIColor.brown
            
        default:
            selectedColor = UIColor.black
            break
            
        }
        
        let theViewController = presentingViewController as! ViewController

        theViewController.setColor(selectedColor)
        
        dismiss(animated: true, completion: nil)

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
