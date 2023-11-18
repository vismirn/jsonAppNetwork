//
//  Content.swift
//  jsonAppNetwork
//
//  Created by Viktor Smirnov on 10.11.2023.
//

import Foundation

struct DogRandom {
    let urlRandom = URL(string: "https://dog.ceo/api/breeds/image/random")!
    let urlDogRandom = URL(string: "https://images.dog.ceo/breeds/saluki/n02091831_8847.jpg")!
}


struct GetUrlPhoto: Decodable {
    let message: String
    let status: String
    
    static func getUrlRandom(from value: Any) -> String {
        guard let urlData = value as? [String: String] else { return "" }

        var getUrlPhoto = GetUrlPhoto.init(message: urlData["message"] ?? "", status: urlData["status"] ?? "")
        
        return getUrlPhoto.message
    }
}
