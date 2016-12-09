//
//  DetailsMusicVideoVC.swift
//  MusicVideo
//
//  Created by Walid Sassi on 02/12/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class DetailsMusicVideoVC: UIViewController {
    var video : Videos!
    @IBOutlet weak var Vname: UILabel!
    @IBOutlet weak var Vrights: UILabel!
    @IBOutlet weak var Vprice: UILabel!
    @IBOutlet weak var Vgenre: UILabel!
    @IBOutlet weak var Vimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Vname.text = video.vName
        Vrights.text = video.vRights
        Vprice.text = video.vPrice
        Vgenre.text = video.vGenre
        print(Vprice.text)
        if video.vImageData != nil {
            Vimage.image = UIImage(data:video.vImageData!)
        }
        else
        {
           Vimage.image = UIImage(named: "img_not_available")  
        }
    }
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        sharedMedia()
    }
    func sharedMedia(){
        let activity1 = "have you had the opprotunity to see this Music Video ?"
        let activity2 = ("\(video.vName)")
        let activity3 = " Watch it and tell me what you this ?"
        let activity4 =  video.vLinkToiTunes
        let activity5 = "(shared with the music video App)"
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1,activity2,activity3,activity4,activity5], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activity,sucess,items,error) in
            if activity == UIActivityTypeMail {
                print ("email selected")
            }
        }
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

    @IBAction func playVideo(sender: UIBarButtonItem) {
        let url = NSURL(string: video.vLinkToiTunes)
        print(video.vVideoUrl)
        let player = AVPlayer(URL: url!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true){
            playerViewController.player?.play()
        }
    }

    
}
