//
//  ApiRequest.swift
//  VodafoneTask
//
//  Created by OmarMansour on 7/27/21.
//

import Foundation

func ApiRequest(page: String , callback: @escaping (HTTPURLResponse , Data?) -> ()){
    
    let semaphore = DispatchSemaphore (value: 0)
    
    var request = URLRequest(url: URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=10")!,timeoutInterval: Double.infinity)
    
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            print(String(describing: error))
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse{
            if httpResponse.statusCode/100 == 2{
                callback(httpResponse , data)
            }
            else {
                print(httpResponse)
            }
            
        }
        
        semaphore.signal()
    }
    
    task.resume()
    semaphore.wait()
}
