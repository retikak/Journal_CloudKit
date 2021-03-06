//
//  EntryListTableViewController.swift
//  Journal_CloudKit_BreakDown
//
//  Created by Diego Aguirre on 8/7/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(entriesWereUpdated), name: EntriesControllerDidRefreshNotification, object: nil)
    }
    
    func entriesWereUpdated(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedController.entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)
        
        let entry = EntryController.sharedController.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        
        return cell
    }
    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            
//            let entry = EntryController.sharedController.entries[indexPath.row]
//            
//            EntryController.sharedController.removeEntry(entry)
//            
//            // Delete the row from the table view
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//            
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toShowEntry" {
            
            if let detailViewController = segue.destinationViewController as? EntryDetailViewController,
                let selectedIndex = tableView.indexPathForSelectedRow?.row {
                
                let entry = EntryController.sharedController.entries[selectedIndex]
                detailViewController.entry = entry
            }
        }
    }
}
