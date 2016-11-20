//
//  ViewController.swift
//  MusicVideo
//
//  Created by Walid Sassi on 13/11/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var TableView: UITableView!
var videos = [Videos]()
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "ReachabiltyStatusChanged", name: "ReachStatusChanged", object: nil)
        ReachabiltyStatusChanged()        // Appel de API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json",completion:didloadData)
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
        Label.text = "Pas de connexion Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
        Label.text = "Wifi Existant "
        case WWAN :view.backgroundColor = UIColor.yellowColor()
        Label.text = "Réseau cellulaire existant"
        default : return
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        return cell
    }
   

}

