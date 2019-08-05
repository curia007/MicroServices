//
//  HostingController.swift
//  WebCamApp WatchKit Extension
//
//  Created by Carmelo Uria on 6/27/19.
//  Copyright © 2019 Carmelo Uria Corporation. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

import WebCam

class HostingController : WKHostingController<ContentView>
{
    let webCamManager : WebCamManager = WebCamManager()

    override var body: ContentView
    {
        webCamManager.execute(latitude: "43.571486", longitude: "-116.1182923") { (any, error) in
            guard let error : Error = error else
            {
                
            }
            else
            {
                
            }
        }
        return ContentView()
    }
}
