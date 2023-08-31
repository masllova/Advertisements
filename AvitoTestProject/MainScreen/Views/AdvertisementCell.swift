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
    var isFavorite: Bool = false {
        didSet {
            let imageName = isFavorite ? "heart.fill" : "heart"
            favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    var favoriteButtonTapped: (() -> Void)?
    
    var imageURL: URL? {
        didSet { loadImage() }
    }
    private var imageView: UIImageView!
    private var loadingIndicator: UIActivityIndicatorView!
    private var favoriteButton: UIButton!
    private var mapin: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addShadow()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageURL = nil
        imageView.image = nil
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
            
            loadingIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
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
            
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    private func addShadow() {
        layer.cornerRadius = 11
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 3
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    @objc private func objcFavoriteButtonTapped() {
        favoriteButtonTapped?()
        isFavorite = !isFavorite
    }
    private func imageSetUp() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        loadingIndicator = UIActivityIndicatorView(style: .gray)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)
        favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(objcFavoriteButtonTapped), for: .touchUpInside)
        favoriteButton.tintColor = .white
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(favoriteButton)
    }
    private func titlePanelSetUp() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        priceLabel = UILabel()
        priceLabel.font = .boldSystemFont(ofSize: 16)
        priceLabel.textColor = .label
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)
    }
    private func infPanelSetUp() {
        mapin = UIImageView(image: UIImage(systemName: "mappin"))
        mapin.translatesAutoresizingMaskIntoConstraints = false
        mapin.tintColor = .red
        contentView.addSubview(mapin)
        locationLabel = UILabel()
        locationLabel.font = .systemFont(ofSize: 10)
        locationLabel.textColor = .support
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(locationLabel)
        dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 9)
        dateLabel.textColor = .support
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
    }
    private func loadImage() {
        guard let imageURL = imageURL else { return }
        loadingIndicator.startAnimating()
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.imageView.image = image
                    self.imageView.layer.cornerRadius = 8
                    self.imageView.clipsToBounds = true
                }
            }
        }
    }

}
