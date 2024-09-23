//
//  Characters.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let info: Info
    let results: [ResultCharacters]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
}

// MARK: - Result
struct ResultCharacters: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
