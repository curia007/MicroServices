//
//  ServiceProcessor.swift
//  MicroServiceManager
//
//  Created by Carmelo Uria on 6/27/19.
//  Copyright © 2019 Carmelo Uria Corporation. All rights reserved.
//

import Foundation

open class ServiceProcessor
{
    public var sessionDataTask: URLSessionDataTask?
    
    public let session:  URLSession = URLSession(configuration: URLSessionConfiguration.default)

    public init()
    {
    }
    
    open func execute(completion: @escaping ((Data?, URLResponse?, Error?)) -> Void)
    {
        
    }
    
    open func getSession() -> URLSession
    {
        return session
    }
    
}
