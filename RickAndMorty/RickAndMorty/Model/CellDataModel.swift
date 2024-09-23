//
//  CellDataModel.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import Foundation

struct CellDataModel {
    let id: Int
    let name: String
    let gender: String
    let avatar: String
    
    init(model: ResultCharacters) {
        self.id = model.id
        self.name = model.name
        self.gender = model.gender
        self.avatar = model.image
    }
}
