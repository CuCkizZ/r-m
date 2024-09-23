//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchAllCharacters(completion: @escaping (Result<[ResultCharacters], Error>) -> Void)
    func fetchCurrentCharacter(with id: Int, completion: @escaping (Result<DetailCharacter, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    private let networkService = NetworkService.shared
    private let decoder = JSONDecoder()
    
    func fetchAllCharacters(completion: @escaping (Result<[ResultCharacters], Error>) -> Void) {
        networkService.fetchData { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = try self.decoder.decode(Welcome.self, from: data)
                    completion(.success(jsonDecoder.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error parse \(error)")
            }
        }
    }
    
    func fetchCurrentCharacter(with id: Int, completion: @escaping (Result<DetailCharacter, any Error>) -> Void) {
        networkService.fetchCurrentCharacter(with: id) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = try self.decoder.decode(DetailCharacter.self, from: data)
                    completion(.success(jsonDecoder))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error parse \(error)")
            }
        }
    }
    
}

