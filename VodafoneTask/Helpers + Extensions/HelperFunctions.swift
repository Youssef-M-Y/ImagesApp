//
//  HelperFunctions.swift
//  VodafoneTask
//
//  Created by OmarMansour on 7/27/21.
//

import Foundation
import UIKit

class HelperMethods{
    
    class func loadImage(urlString: String) -> UIImage{
        var image = UIImage()
        
        do {
            let url = URL(string: urlString)
            let data = try Data(contentsOf: url!)
            image =  UIImage(data: data)!
        }
        catch{
            print(error)
        }
        
        return image
    }
}
