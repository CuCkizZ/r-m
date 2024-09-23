//
//  ModuleBuilder.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import UIKit

final class ModuleBuilder {
    
    func createListViewController() -> UIViewController {
        let network: NetworkManagerProtocol = NetworkManager()
        let router: RouterProtocol = Router()
        let vm = CharacterListViewModel(networkManager: network)
        let vc = CharactersListViewController(viewModel: vm)
        vc.router = router
        return vc
    }
    
    func createDetailViewController(with id: Int) -> UIViewController {
        let network: NetworkManagerProtocol = NetworkManager()
        let vm = DetailViewModel(networkManager: network, id: id)
        let vc = DetailViewController(viewModel: vm)
        return vc
    }
    
}
