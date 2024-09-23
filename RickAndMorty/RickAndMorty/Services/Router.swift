//
//  Router.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import UIKit

protocol RouterProtocol: AnyObject {
    func modelPresent(from: UIViewController, with id: Int)
}

final class Router: RouterProtocol {
    private let moduleBuilder = ModuleBuilder()
    
    func modelPresent(from: UIViewController, with id: Int) {
        let dvc = moduleBuilder.createDetailViewController(with: id)
        from.present(dvc, animated: true)
    }
    
}
