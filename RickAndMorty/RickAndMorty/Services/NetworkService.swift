//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private let urlString = "https://rickandmortyapi.com/api/character"
    private init() {}
    
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
    
    func fetchCurrentCharacter(with id: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)") else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
    
}
