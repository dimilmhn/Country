//
//  CoreNetworkService.swift
//  ItsMyContry
//
//  Created by Dimil T Mohan on 7/24/18.
//  Copyright © 2018 Dimil T Mohan. All rights reserved.
//

import Foundation

class CoreNetworkService: NSObject {
    
    override init() {
        super.init()
    }
    var completion:((Any?) -> Void)? = nil
    
    func requestGetData(url:String,completion: @escaping (Any?) -> Void, andError completionError: @escaping  (Any?) -> Void) {
        guard let url = URL(string:url) else {
            completion(nil)
            return
        }
        let urlSession = URLSession(configuration:URLSessionConfiguration.default)
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: 10.0 * 100)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = urlSession.dataTask(with: urlRequest)
        { (data, response, error) -> Void in
            
            guard error == nil else {
                print("Error while fetching remote rooms:")
                completionError(error) //return error
                return
            }
            completion(data) //return the data
        }
        task.resume()
        
    }
    
    
    
}


