//
//  Content.swift
//  jsonAppNetwork
//
//  Created by Viktor Smirnov on 10.11.2023.
//

import Foundation

struct Content {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
    let residents: [Any]
    let films: [Any]
    let created: String
    let edited: String
    let url: String
    let urlNeed: String = "https://swapi.dev/api/planets/3/?format=json"
}

struct DogRandom {
    let urlRandom = URL(string: "https://dog.ceo/api/breeds/image/random")!
    let urlDogRandom = URL(string: "https://images.dog.ceo/breeds/saluki/n02091831_8847.jpg")!
}


struct GetUrlPhoto: Decodable {
    let message: String
    let status: String
}
