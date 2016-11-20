//
//  ViewController.swift
//  MusicVideo
//
//  Created by Walid Sassi on 13/11/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Label: UILabel!
var videos = [Videos]()
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "ReachabiltyStatusChanged", name: "ReachStatusChanged", object: nil)
        ReachabiltyStatusChanged()        // Appel de API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",completion:didloadData)
    }
    func didloadData(videos:[Videos] )
    {
        self.videos = videos
        for item in videos
        {
            print("le nom est \(item.vName)")
        }
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
   
    

}

