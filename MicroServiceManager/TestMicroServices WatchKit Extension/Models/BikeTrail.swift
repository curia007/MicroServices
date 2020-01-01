//
//  BikeTrail.swift
//  TestMicroServices WatchKit Extension
//
//  Created by Carmelo Uria on 12/31/19.
//  Copyright © 2019 Carmelo Uria Corporation. All rights reserved.
//

import Foundation

struct BikeTrail : Codable
{
    var city : String
    var country : String
    var description : String
    var difficulty : String?
    var directions : String
    var features : String
    var id : String
    var lat : String
    var length : String
    var lon : String
    var name : String
    var rating : String
    var region : String
    var thumbnail : String
    var url : String
}
