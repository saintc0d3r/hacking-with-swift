//
//  MasterViewController.swift
//  project1_storm_viewer
//
//  Created by Wendy Sanarwanto on 1/6/16.
//  Copyright © 2016 Wendy Sanarwanto. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    // Array property to hold a list of image filenames
    var objects = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        load_images_list()
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                // Passing touched detail item into Detail View controller
                let navigation_controller = segue.destinationViewController as! UINavigationController
                let controller = navigation_controller.topViewController as! DetailViewController
                controller.detailItem = objects[indexPath.row]
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        // Fill each table's cell with image's file name
        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func load_images_list(){
        // instantiate file manager object
        let file_manager = NSFileManager.defaultManager()
        
        // refer to main bundle and get the main bundle's resource path
        let resource_path = NSBundle.mainBundle().resourcePath
        
        // get contents inside the resource path
        let contents = try! file_manager.contentsOfDirectoryAtPath(resource_path!)
        
        // Iterate on each files inside the resource path
        for content in contents{
            if content.hasPrefix("nssl"){
                objects.append(content)
            }
        }
    }
}

