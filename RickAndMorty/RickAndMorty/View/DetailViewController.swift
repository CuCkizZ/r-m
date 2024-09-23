//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    private let viewModel: DetailViewModelProtocol
    private var information: DetailCharacter?

    private lazy var activityIndicator = UIActivityIndicatorView()
    private lazy var avatarImageView = UIImageView()
    private lazy var nameLabel = UILabel()
    
    private lazy var statusLabel = UILabel()
    private lazy var genderLabel = UILabel()
    private lazy var typeLabel = UILabel()
    private lazy var speciesLabel = UILabel()
    
    private lazy var constantGenderLabel = UILabel()
    private lazy var constantStatusLabel = UILabel()
    private lazy var constantSpeciesLabel = UILabel()
    private lazy var constantTypeLabel = UILabel()
    
    private lazy var infoStackView = UIStackView(arrangedSubviews: [
        genderLabel,
        statusLabel,
        speciesLabel,
        typeLabel
    ])
    
    private lazy var constantsStackView = UIStackView(arrangedSubviews: [
        constantGenderLabel,
        constantStatusLabel,
        constantSpeciesLabel,
        constantTypeLabel
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupLayout()
        configure()
    }
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DetailViewController {
    func setupLayout() {
        setupView()
        setupInfoStackView()
        setupConstantsStackView()
        setupLabels()
        setupConstantsLabels()
        setupConstraints()
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                    self.constantsStackView.isHidden = true
                } else {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.constantsStackView.isHidden = false
                    self.information = self.viewModel.model
                    self.configure()
                }
            }
        }
    }
    
    func configure() {
        guard let model = information else { return }
        avatarImageView.downloadImage(urlString: model.image)
        nameLabel.text = model.name
        genderLabel.text = model.gender
        statusLabel.text = model.status
        speciesLabel.text = model.species
        typeLabel.text = checkType(type: model.type)
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(infoStackView)
        view.addSubview(constantsStackView)
        view.addSubview(activityIndicator)
    }
    
    func setupInfoStackView() {
        infoStackView.axis = .vertical
        infoStackView.alignment = .center
        infoStackView.spacing = 16
    }
    
    func setupConstantsStackView() {
        constantsStackView.axis = .vertical
        constantsStackView.alignment = .center
        constantsStackView.spacing = 28
    }
    
    func setupLabels() {
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        statusLabel.configureInfoLabel()
        speciesLabel.configureInfoLabel()
        genderLabel.configureInfoLabel()
        typeLabel.configureInfoLabel()
    }
    
    func setupConstantsLabels() {
        constantGenderLabel.configureConstantLabel()
        constantStatusLabel.configureConstantLabel()
        constantSpeciesLabel.configureConstantLabel()
        constantTypeLabel.configureConstantLabel()
        
        constantStatusLabel.text = Constants.statusString
        constantGenderLabel.text = Constants.genderString
        constantTypeLabel.text = Constants.typeString
        constantSpeciesLabel.text = Constants.speciesString
    }
    
    func checkType(type: String) -> String {
        if type == "" {
           return Constants.noneString
        } else {
            return type
        }
    }
    
    func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.right.left.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(350)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarImageView.snp.bottom).inset(-16)
        }
        infoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).inset(-16)
        }
        constantsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).inset(-40)
        }
    }
    
}
