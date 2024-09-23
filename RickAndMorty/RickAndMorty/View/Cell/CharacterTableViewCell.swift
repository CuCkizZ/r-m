//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Nikita Beglov on 23.09.2024.
//

import UIKit
import SnapKit

final class CharacterTableViewCell: UITableViewCell {
    static let reuseId = "CharacterCell"
    
    private lazy var nameLabel = UILabel()
    private lazy var genderLabel = UILabel()
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: CharacterTableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: CharacterTableViewCell.reuseId)
        setupLayout()
        prepareForReuse()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: CellDataModel) {
        nameLabel.text = model.name
        genderLabel.text = model.gender
        avatarImageView.downloadImage(urlString: model.avatar)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
    
}

private extension CharacterTableViewCell {
    func setupLayout() {
        setupView()
        setupLabels()
        setupConstraints()
    }
    
    func setupView() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderLabel)
    }
    
    func setupLabels() {
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        genderLabel.configureConstantLabel()
    }
    
    func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.height.width.equalTo(100)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(avatarImageView.snp.right).inset(-16)
        }
        genderLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).inset(-16)
            make.top.equalTo(nameLabel.snp.bottom).inset(-16)
        }
    }
    
}
