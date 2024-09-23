//
//  DetailViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import Foundation

protocol DetailViewModelProtocol {
    var isLoading: Observable<Bool> { get set }
    var model: DetailCharacter? { get }
    
    func fetchData()
    
}

final class DetailViewModel {
    var model: DetailCharacter?
    var isLoading: Observable<Bool> = Observable(false)
    
    private var id: Int
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol, id: Int) {
        self.networkManager = networkManager
        self.id = id
        fetchData()
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func fetchData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        networkManager.fetchCurrentCharacter(with: id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.model = data
                    self.isLoading.value = false
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
