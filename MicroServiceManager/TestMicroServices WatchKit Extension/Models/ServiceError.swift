//
//  ServiceError.swift
//  TestMicroServices WatchKit Extension
//
//  Created by Carmelo Uria on 1/1/20.
//  Copyright © 2020 Carmelo Uria Corporation. All rights reserved.
//

import Foundation

struct ServiceError : Codable
{
    var code : String
    var data : [String : Int]
    var message : String
}
