//
//  ViewController.swift
//  MusicVideo
//
//  Created by Walid Sassi on 13/11/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Appel de API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",completion:didloadData)
    }
    func didloadData(result:String)
    {
        print(result)
    }

    

}

