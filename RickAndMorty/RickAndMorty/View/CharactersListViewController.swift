//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import UIKit
import SnapKit

final class CharactersListViewController: UIViewController {
    var router: RouterProtocol?
    
    private let viewModel: CharacterListViewModelProtocol
    private var cellDataSource: [CellDataModel] = []
    
    private let titleString = "Characters"
    private lazy var activityIndicator = UIActivityIndicatorView()
    private lazy var titleLabel = UILabel()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    init(viewModel: CharacterListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.fetchData()
        bindView()
        bindViewModel()
        setupLayout()
    }
    
    
}

private extension CharactersListViewController {
    func setupLayout() {
        setupView()
        setupTitleLabel()
        setupTableView()
        setupConstraints()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            }
        }
    }
    
    func bindView() {
        viewModel.cellDataSource.bind { [weak self] characters in
            guard let self = self, let characters = characters else { return }
            self.cellDataSource = characters
            tableView.reloadData()
        }
    }
    
    func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    func setupTitleLabel() {
        titleLabel.text = titleString
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        titleLabel.textAlignment = .center
    }
    
    func setupTableView() {
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
    
}

extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = cellDataSource[indexPath.row].id
        router?.modelPresent(from: self, with: id)
    }
}

extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellDataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseId,
                                                       for: indexPath) as? CharacterTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        132
    }
    
    
}
