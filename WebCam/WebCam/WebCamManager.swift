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
    
            execute(parameters: parameters, headers: headers, url: url, method: .GET) { (any, response, error) in
            
            }
            
            execute(parameters: parameters, headers: headers, url: url, method: .GET) { (data, response, error) in
                guard let error : Error = error else
                {
                    debugPrint("[\(#function),\(#line)] data : \(String(describing: data))")
                    
                    do
                    {
                        if let data : Data = data
                        {
                            let json : Any = try self.convert(data: data)
                                completion(json, nil)
                        }
                    }
                    catch
                    {
                        completion(nil, error)
                    }
                    
                    completion(data, nil)
                    
                    return
                }
                completion(nil, error)
            }
            
        }
    }
}
