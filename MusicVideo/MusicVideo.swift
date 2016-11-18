//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Walid Sassi on 18/11/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import Foundation

class Videos
{
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    private var _vRights:String
    private var _vPrice:String
    private var _vArtist:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDte:String
    
    var vImageData : NSData?
    // getters
    var vName:String{
        return _vName
    }
    var vImageUrl:String{
        return _vImageUrl
    }
    var vVideoUrl:String{
        return _vVideoUrl
    }
    var vRights:String{
        return _vRights
    }
    var vPrice:String{
        return _vPrice
    }
    var vImid:String{
        return _vImid
    }
    var vGenre:String{
        return _vGenre
    }
    var vLinkToiTunes:String{
        return _vLinkToiTunes
    }
    var vReleaseDte:String{
        return _vReleaseDte
    }
    
    init (data :JSONDictionnary)
    {
        // recupération du nom
        if let name = data["im:name"] as? JSONDictionnary,
            vName = name["label"] as? String {
            self._vName = vName
        }
        else
        {
            _vName=""
        }
        // récupération de @ URL de l'image
        if let img = data["im:image"] as? JSONArray,
        image = img[2] as? JSONDictionnary,
            immage = image["label"] as? String {
            self._vImageUrl = immage.stringByReplacingOccurrencesOfString("100X100", withString: "600X600")
        }
        else{
            _vImageUrl=""
        }
        // récupération de @ URL de la vidéo
        if let video = data["link"] as? JSONArray,
        vURL = video[1] as? JSONDictionnary,
        vHref = vURL["attributes"]as? JSONDictionnary,
        vVideoUrl = vHref["href"] as? String
        {
            self._vVideoUrl=vVideoUrl
        }
        else
        {
            _vVideoUrl=""
        }
        
        if let right = data["rights"] as? JSONDictionnary,
            label = right["label"] as? String {
            self._vRights = label
        }
        else
        {
            _vRights = ""
            
        }
        
        if let price = data["price"] as? JSONDictionnary,
            label = price["label"] as? String {
            self._vPrice = label
        }
        else
        {
            _vPrice  = ""
            
        }
        
        if let artist = data["im:artist"] as? JSONDictionnary,
            label = artist["label"] as? String {
            self._vArtist = label
        }
        else
        {
            _vArtist = ""
            
        }
        
        if let vlmid = data["id"] as? JSONDictionnary,
            vid = vlmid["label"] as? JSONDictionnary,
            vImid = vid["im:id"] as? String
        {
            self._vImid = vImid 
        }
        else
        {
            _vImid = ""
            
        }
        
        if let category = data["category"] as? JSONDictionnary,
            attr = category["attributes"] as? JSONDictionnary ,
            vGenre = attr["term"] as? String
        {
            self._vGenre = vGenre
        }
        else
        {
            _vGenre = ""
            
        }
        
        if let release = data["im:releaseDate"] as? JSONDictionnary,
        label  = release["label"] as? String
        {
            self._vReleaseDte = label
        }
            
        else
        {
            _vReleaseDte = ""
        }
        
        if let video = data["link"] as? JSONArray,
            vURL = video[0] as? JSONDictionnary,
            vHref = vURL["attributes"]as? JSONDictionnary,
            vVideoUrl = vHref["href"] as? String
        {
            self._vLinkToiTunes=vVideoUrl
        }
        else
        {
            _vLinkToiTunes=""
        }


    }
    
}
