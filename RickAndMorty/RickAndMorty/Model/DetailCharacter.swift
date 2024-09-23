//
//  DetailCharacter.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import Foundation

struct DetailCharacter: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let image: String
}

