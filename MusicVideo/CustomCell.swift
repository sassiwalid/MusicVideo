//
//  CustomCell.swift
//  MusicVideo
//
//  Created by Walid Sassi on 26/11/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var name: UILabel!
    var video : Videos?
        {
        didSet{
            updatecell()
        }
    }
    func updatecell(){
        name.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        name.text = video?.vName
        rank.text = video?.vImid
        if video!.vImageData != nil {
            print("Get Data from Array")
            myImage.image = UIImage(data:video!.vImageData!)
        }
        else{
            GetAlbumImage(video!, imageview: myImage)
        }
    }
    func GetAlbumImage (video:Videos, imageview:UIImageView)
        // Background Thread
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
            let data = NSData (contentsOfURL: NSURL(string : video.vImageUrl)!)
            var image: UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data:data!)
            }
            // move back to main thread
            dispatch_async(dispatch_get_main_queue())
            {
                self.myImage.image = image
            }
        }
        
    }

}
