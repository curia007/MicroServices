//
//  MicroServicesModel.swift
//  TestMicroServices WatchKit Extension
//
//  Created by Carmelo Uria on 12/31/19.
//  Copyright © 2019 Carmelo Uria Corporation. All rights reserved.
//

import Foundation

import MicroServiceManager

struct MicroServicesModel
{
    fileprivate var processor : ServiceProcessor = ServiceProcessor()
    
    internal mutating func execute()
    {
        /*
        curl --request GET \
        --url 'https://trailapi-trailapi.p.rapidapi.com/trails/explore/?lat=43.571348137422184&lon=-116.11842536072987' \
        --header 'x-rapidapi-host: trailapi-trailapi.p.rapidapi.com' \
        --header 'x-rapidapi-key: zq5He9XmuEmshqt1knmehZbjzjlep19yXUHjsn31uHGHW6zRBZ'
         */
        
        guard let url : URL = URL(string: "https://trailapi-trailapi.p.rapidapi.com/trails/explore/") else {
            print("Invalid URL")
            return
        }
        
        let headers : [String : String] = ["x-rapidapi-host" : "trailapi-trailapi.p.rapidapi.com", "x-rapidapi-key" : "zq5He9XmuEmshqt1knmehZbjzjlep19yXUHjsn31uHGHW6zRBZ"]
        let query : [String : Any] = ["lat" : "43.571348137422184", "long" : "-116.11842536072987"]
        
        processor.execute(headers : headers, requestURL: url, query : query) { (data, response, error) in
            print("test")
        }
        
    }
}
