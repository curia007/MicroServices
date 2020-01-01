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
    fileprivate let processor : ServiceProcessor = ServiceProcessor()

    internal func execute()
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
        let query : [String : Any] = ["lat" : "43.571348137422184", "lon" : "-116.11842536072987"]
        
        processor.execute(headers : headers, requestURL: url, query : query) { (data, response, error) in
            if let error : Error = error
            {
                print("error: \(error.localizedDescription)")
                return
            }
            else if let data: Data = data
            {
                let bikeTrailData : BikeTrailData  = self.processor.convert(data: data)
                let bikeTrails : [BikeTrail] = bikeTrailData.data
                
                debugPrint("bike trails: \(bikeTrails)")
                
                /*
                do {
                    
                    let any : Any = try self.processor.convert(data: data)
                    print("any: \(any)")
                    
                    if let dictionary : [String : Any] = any as? [String : Any]
                    {
                        print("dictionary: \(dictionary)")
                    }
                }
                catch
                {
                    print("error: \(error.localizedDescription)")
                }
                */
            }
        }
        
    }
}
