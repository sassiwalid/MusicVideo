//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Walid Sassi on 04/12/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {
    @IBOutlet weak var feedbackDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!
    
    @IBOutlet weak var bestimageDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var sliderCnt: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SettingsTVC.fontchanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        tableView.alwaysBounceVertical = false
    }
    func fontchanged()
    {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestimageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    
}
