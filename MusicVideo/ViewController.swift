//
//  ViewController.swift
//  MusicVideo
//
//  Created by Walid Sassi on 13/11/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var TableView: UITableView!
    // tableau des vidéos
    var videos = [Videos]()
    var limit = 10
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.ReachabiltyStatusChanged), name: "ReachStatusChanged", object: nil)
        ReachabiltyStatusChanged()        // Appel de API
//        refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(ViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
//        TableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    func refresh(sender:UIRefreshControl) {
        // Code to refresh table view
        refreshControl.endRefreshing()
        getAPICount()
    }
    func getAPICount(){
        if ((NSUserDefaults.standardUserDefaults().objectForKey("APIcntSetting")) != nil){
          let thevalue = NSUserDefaults.standardUserDefaults().objectForKey("APIcntSetting") as! Int
        limit = thevalue
        }
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MMMM YYYY"
        let refreshDte = formatter.stringFromDate(NSDate())
        TableView.refreshControl?.attributedTitle = NSAttributedString(string:"\(refreshDte)")
        
    }
    func runAPI()
    {
        getAPICount()
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json",completion:didloadData)
    }
    func didloadData(videos:[Videos] )
    {
        self.videos = videos
        TableView.reloadData()
    }
    func ReachabiltyStatusChanged()
    {
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
        print(reachabilityStatus)
        let alert = UIAlertController(title:"Pas de connexion Internet", message: "Verifiez votre connexion ", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style:.Default){
            action -> () in print("Cancel")
            }
        let deleteAction = UIAlertAction(title: "Delete", style:.Destructive){
            action -> () in print("Delete")
            }
        let okAction = UIAlertAction(title: "OK", style:.Default){
            action -> () in print("OK")
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            self.presentViewController(alert, animated: true, completion: nil)
        default:
            print(reachabilityStatus)
            runAPI()
            
        }
    }
    // appel de destructeur et destruction de l'observer
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
    return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        cell.video = videos[indexPath.row]

        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToDetails"{
            if let indexpath = TableView.indexPathForSelectedRow{
                let video = videos[indexpath.row]
                let dvc = segue.destinationViewController as! DetailsMusicVideoVC
                dvc.video = video
            }
        }
        
    }


}

