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
    
    open func execute(parameters : [String : Any], completion: @escaping ((Data?, URLResponse?, Error?)) -> Void)
    {
        if let url : URL = parameters["url"] as? URL
        {
            if let httpMethod : String = parameters["httpMethod"] as? String
            {
                var request : URLRequest = URLRequest(url: url)
                request.httpMethod = httpMethod
                
                self.sessionDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    guard let error = error else {
                        guard let data = data else {
                            let myerror : Error = MyError.responseStatusError(status: 0, message: "Web Service called, but no error code or data")
                            completion((nil, nil, myerror))
                            return
                        }
                        completion((data, nil, nil))
                        return
                    }
                    completion((nil, nil, error))
                })
                
                if let sessionDataTask : URLSessionDataTask = self.sessionDataTask
                {
                    sessionDataTask.resume()
                }
            }
        }

    }
    
    open func getSession() -> URLSession
    {
        return session
    }
    
}

public enum MyError: Error
{
    case responseStatusError(status: Int, message: String)
}

extension MyError: LocalizedError
{
    private var errorDescription: String {
        switch self {
        case let .responseStatusError(status, message):
            return "Error with status \(status) and message \(message) was thrown"
        }
    }
}

