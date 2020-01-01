//
//  BikeTrailData.swift
//  TestMicroServices WatchKit Extension
//
//  Created by Carmelo Uria on 12/31/19.
//  Copyright © 2019 Carmelo Uria Corporation. All rights reserved.
//

import Foundation

struct BikeTrailData : Codable
{
    var results : Int
    var data : [BikeTrail]
}
