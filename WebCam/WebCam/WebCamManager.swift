//
//  WebCamManager.swift
//  MicroServiceManager
//
//  Created by Carmelo Uria on 6/27/19.
//  Copyright © 2019 Carmelo Uria Corporation. All rights reserved.
//

import Foundation


public final class WebCamManager : ServiceProcessor
{
    fileprivate let base : String = "webcamstravel.p.rapidapi.com"
    fileprivate let headers : [String : String] = ["X-RapidAPI-Key" : "zq5He9XmuEmshqt1knmehZbjzjlep19yXUHjsn31uHGHW6zRBZ", "X-RapidAPI-Host" : "webcamstravel.p.rapidapi.com"]
    
    public override init()
    {
    }
    
    public func execute(parameters: [String: String], completion: @escaping ((Data?, URLResponse?, Error?) -> Void))
    {
        let host : String = "https://" + base
        
        if let url : URL = URL(string: host)
        {
            if let httpMethod : String = parameters["httpMethod"]
            {
                var request : URLRequest = URLRequest(url: url)
                request.httpMethod = httpMethod
                
                self.sessionDataTask = session.dataTask(with: request, completionHandler: completion)
                
                if let sessionDataTask : URLSessionDataTask = self.sessionDataTask
                {
                    sessionDataTask.resume()
                }
            }
        }
    }
}
