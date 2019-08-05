//
//  WebCamManager.swift
//  MicroServiceManager
//
//  Created by Carmelo Uria on 6/27/19.
//  Copyright © 2019 Carmelo Uria Corporation. All rights reserved.
//

import Foundation

import MicroServiceManager

public final class WebCamManager : ServiceProcessor
{
    fileprivate let base : String = "webcamstravel.p.rapidapi.com"
    fileprivate let headers : [String : String] = ["X-RapidAPI-Key" : "zq5He9XmuEmshqt1knmehZbjzjlep19yXUHjsn31uHGHW6zRBZ", "X-RapidAPI-Host" : "webcamstravel.p.rapidapi.com"]
        
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

    //https://webcamstravel.p.rapidapi.com/webcams/list/nearby=43.57139849416451,-116.1182789707504,50/orderby=distance/limit=20?show=webcams:location,image,url
    
    public func execute(latitude : String, longitude: String, completion: @escaping ((Any?, Error?) -> Void) )
    {
        var parameters : [String : Any] = [:]
        var headers : [String : String] = [:]
        let host : String = "https://\(base)/webcams/list/nearby=\(latitude),\(longitude),50/orderby=distance/limit=20?show=webcams:location,image,url"
        
        if let url : URL = URL(string: host)
        {
            parameters["httpMethod"] = "GET"
            
            // HTTP Headers
            headers["X-RapidAPI-Host"] = "webcamstravel.p.rapidapi.com"
            headers["X-RapidAPI-Key"] = "zq5He9XmuEmshqt1knmehZbjzjlep19yXUHjsn31uHGHW6zRBZ"
            
            super.execute(parameters: parameters, headers: headers, url: url, method: .GET) { (data, response, error) in
                guard let error : Error = error else
                {
                    debugPrint("[\(#function),\(#line)] data : \(String(describing: data))")
                    completion(data, nil)
                    return
                }
                completion(nil, error)
            }
            
        }
    }
}
