//
//  ServiceProcessor.swift
//  MicroServiceManager
//
//  Created by Carmelo Uria on 6/27/19.
//  Copyright © 2019 Carmelo Uria Corporation. All rights reserved.
//

import Foundation

public class ServiceProcessor
{
    public var sessionDataTask: URLSessionDataTask?
    
    public let session:  URLSession = URLSession(configuration: URLSessionConfiguration.default)
      
    public init()
    {
        
    }
    
    public func execute(parameters : [String : Any] = [:], headers : [String : String] = [:], requestURL : URL, query : [String : Any] = [:], method : HTTPMethod = .GET, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    {
        var url : URL = requestURL
        
        // check query and append if needed
        if let queryExtenscommand : String = constructQuery(url: url, query: query)
        {
            if let appendedURL = URL(string: url.absoluteString + queryExtenscommand)
            {
                url = appendedURL
            }
        }
        
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
                    let sessionError : Error = ServiceError.responseStatusError(status: 0, message: "Web Service called, but no error code or data")
                    completion(nil, nil, sessionError)
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
    
    public func getSession() -> URLSession
    {
        return session
    }
    
    public func convert<T: Decodable>(data : Data) throws -> T?
    {
        do
        {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }
        catch
        {
            //fatalError("Couldn't parse \(T.self):\n\(error)")
            ServiceError.responseStatusError(status: -1, message:"Couldn't parse \(T.self):\n\(error)")
        }
        
        return nil
    }
    
    public func convert(data : Data, options opt: JSONSerialization.ReadingOptions = []) throws -> Any
    {
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
    
    public func convert(json : Any, options opt: JSONSerialization.WritingOptions = []) throws -> Data
    {
        return try JSONSerialization.data(withJSONObject: json, options: opt)
    }
    
    fileprivate func constructQuery(url: URL, query : [String : Any]) -> String?
    {
        
        if (query.isEmpty == true)
        {
            return nil
        }
        
        var queryString : String = "?"
        
        for (_, a) in query.enumerated()
        {
            guard let value : String = a.value as? String else {
                continue
            }
            
            queryString += "\(a.key)"
            queryString += "=\(value)&"
        }
        
        queryString = String(queryString.dropLast())
        
        debugPrint("queryString: \(queryString)")

        return queryString
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

