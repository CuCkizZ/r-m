//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import Foundation

protocol CharacterListViewModelProtocol {
    var isLoading: Observable<Bool> { get set }
    var cellDataSource: Observable<[CellDataModel]> { get set }
    
    func fetchData()
    func numbersOfRowInSection() -> Int
    
}

final class CharacterListViewModel {
    var cellDataSource: Observable<[CellDataModel]> = Observable(nil)
    var isLoading: Observable<Bool> = Observable(false)
    
    private let networkManager: NetworkManagerProtocol
    private var model: [ResultCharacters] = []
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    private func mpCellData() {
        cellDataSource.value = model.compactMap({ CellDataModel(model: $0) })
    }
}

extension CharacterListViewModel: CharacterListViewModelProtocol {
    func fetchData() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        networkManager.fetchAllCharacters { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.model = model
                    self.mpCellData()
                    self.isLoading.value = false
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func numbersOfRowInSection() -> Int {
        return model.count
    }
    
}
