//
//  AdvertisementCell.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import UIKit

class AdvertisementCell: UICollectionViewCell {
    var titleLabel: UILabel!
    var priceLabel: UILabel!
    var locationLabel: UILabel!
    var dateLabel: UILabel!
    var imageURL: URL? {
        didSet {
            loadImage()
        }
    }
    private var imageView: UIImageView!
    private var favoriteButton: UIButton!
    private var mapin: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        imageSetUp()
        titlePanelSetUp()
        infPanelSetUp()
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            mapin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            mapin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            mapin.heightAnchor.constraint(equalToConstant: 12),
            mapin.widthAnchor.constraint(equalToConstant: 10),
            
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            locationLabel.leadingAnchor.constraint(equalTo: mapin.trailingAnchor, constant: 1),
            
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    private func imageSetUp() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .white
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(favoriteButton)
    }
    private func titlePanelSetUp() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .boldSystemFont(ofSize: 16)
        contentView.addSubview(priceLabel)
    }
    private func infPanelSetUp() {
        mapin = UIImageView(image: UIImage(systemName: "mappin"))
        mapin.translatesAutoresizingMaskIntoConstraints = false
        mapin.tintColor = .red
        contentView.addSubview(mapin)
        locationLabel = UILabel()
        locationLabel.font = .systemFont(ofSize: 10)
        locationLabel.textColor = .darkGray
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)
        dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .darkGray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
    }
    private func loadImage() {
        guard let imageURL = imageURL else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.imageView.layer.cornerRadius = 8
                    self.imageView.clipsToBounds = true
                }
            }
        }
    }
}
