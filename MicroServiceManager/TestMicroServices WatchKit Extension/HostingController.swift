//
//  HostingController.swift
//  TestMicroServices WatchKit Extension
//
//  Created by Carmelo Uria on 12/31/19.
//  Copyright © 2019 Carmelo Uria Corporation. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<ContentView>
{
    override var body: ContentView
    {
        //TODO: remove test
        var model : MicroServicesModel = MicroServicesModel()
        model.execute()
        //
        
        return ContentView()
    }
}
