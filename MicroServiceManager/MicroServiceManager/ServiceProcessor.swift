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
    
    public init ()
    {
        
    }
    
    deinit 
    {
        sessionDataTask = nil
    }
    
    open func execute(parameters : [String : Any], headers : [String : String], url : URL, method : HTTPMethod, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    {
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // add http headers
        for key : String in headers.keys
        {
            if let value : String = headers[key]
            {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        self.sessionDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let error = error else {
                guard let data = data else {
                    let myerror : Error = ServiceError.responseStatusError(status: 0, message: "Web Service called, but no error code or data")
                    completion(nil, nil, myerror)
                    return
                }
                completion(data, nil, nil)
                return
            }
            completion(nil, nil, error)
        })
        
        if let sessionDataTask : URLSessionDataTask = self.sessionDataTask
        {
            sessionDataTask.resume()
        }
    }
    
    open func getSession() -> URLSession
    {
        return session
    }
    
    open func convert(data : Data, options opt: JSONSerialization.ReadingOptions = []) throws -> Any
    {
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
    
    open func convert(json : Any, options opt: JSONSerialization.WritingOptions = []) throws -> Data
    {
        return try JSONSerialization.data(withJSONObject: json, options: opt)
    }
    
}

public enum HTTPMethod : String
{
    case POST
    case GET
    case DELETE
    case PUT
    case HEAD
}

public enum ServiceError: Error
{
    case responseStatusError(status: Int, message: String)
}

extension ServiceError: LocalizedError
{
    private var errorDescription: String {
        switch self {
        case let .responseStatusError(status, message):
            return "Error with status \(status) and message \(message) was thrown"
        }
    }
}

