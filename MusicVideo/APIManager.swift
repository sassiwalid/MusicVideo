//
//  APIManager.swift
//  MusicVideo
//
//  Created by Walid Sassi on 17/11/2016.
//  Copyright © 2016 Walid Sassi. All rights reserved.
//

import Foundation

class APIManager
{
    func loadData (urlString:String, completion:(result:String)->())
    {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        let url = NSURL(string:urlString)!
        let task = session.dataTaskWithURL(url)
        {
        // passer les données au thread principal CallBack
        
          (data,response,error) -> Void  in
            dispatch_async(dispatch_get_main_queue())
            {
                if error != nil
                {
                    completion(result: (error!.localizedDescription))
                }
                else
                {
                    completion(result: "NSURL Successeful")
                    print(data)
                }
            }
        }
        task.resume()
    }
}
