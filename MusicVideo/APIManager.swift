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
          (data,response,error) -> Void  in
            // passer les données au thread principal CallBack
            
                if error != nil
                {
                    dispatch_async(dispatch_get_main_queue())
                    {
            completion(result: (error!.localizedDescription))
                    }
                }
                else
                {
                    do
                    {
    if let json =  try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject]{
                    print(json)
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async(dispatch_get_global_queue(priority,0))
                    {
                      dispatch_async(dispatch_get_main_queue())
                        {
                            completion(result:"JSON Serialisation successful")
                        }
                    }
                }
                    }
                    catch
                    {
                        dispatch_async(dispatch_get_main_queue())
                        {
                            completion(result:"Erreur in JSON Serialisation ")
                        }
                    }
                    // end Json serialisation
            }
        }
        task.resume()
    }
}
