//
//  CoreNetworkService.swift
//  ItsMyContry
//
//  Created by Dimil T Mohan on 7/24/18.
//  Copyright © 2018 Dimil T Mohan. All rights reserved.
//

import Foundation
import Reachability

final class CoreNetworkService: NSObject {
    
    var reachability: Reachability!
    
    // Create a singleton instance
    static let sharedInstance: CoreNetworkService = { return CoreNetworkService() }()
    private override init() {
        super.init()
        
        // Initialise reachability
        reachability = Reachability()!
        
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    // MARK: API calls
    
    func requestGetData(url:String,completion: @escaping (Any?) -> Void, andError completionError: @escaping  (Any?) -> Void) {
        CoreNetworkService.isReachable { networkManagerInstance in
            print("Network is available")
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
    
    
    // MARK: Reachability methods
    
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (CoreNetworkService.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completed: @escaping (CoreNetworkService) -> Void) {
        if (CoreNetworkService.sharedInstance.reachability).connection != .none {
            completed(CoreNetworkService.sharedInstance)
        }
    }
    
    // Network is unreachable
    static func isUnreachable(completed: @escaping (CoreNetworkService) -> Void) {
        if (CoreNetworkService.sharedInstance.reachability).connection == .none {
            completed(CoreNetworkService.sharedInstance)
        }
    }
    
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (CoreNetworkService) -> Void) {
        if (CoreNetworkService.sharedInstance.reachability).connection == .cellular {
            completed(CoreNetworkService.sharedInstance)
        }
    }
    
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (CoreNetworkService) -> Void) {
        if (CoreNetworkService.sharedInstance.reachability).connection == .wifi {
            completed(CoreNetworkService.sharedInstance)
        }
    }
}


