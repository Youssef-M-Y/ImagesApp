//
//  ApiRequest.swift
//  VodafoneTask
//
//  Created by OmarMansour on 7/27/21.
//

import Foundation

func ApiRequest(method: String, url:String , callback: @escaping (HTTPURLResponse , Data?) -> ()){
    
    let semaphore = DispatchSemaphore (value: 0)
    
    var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
    
    request.httpMethod = method
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        if let httpResponse = response as? HTTPURLResponse{
            callback(httpResponse , data)
        }
        semaphore.signal()
    }
    
    task.resume()
    semaphore.wait()
}
