//
//  ImageModel.swift
//  VodafoneTask
//
//  Created by OmarMansour on 7/27/21.
//

import Foundation

struct ImageModel: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
