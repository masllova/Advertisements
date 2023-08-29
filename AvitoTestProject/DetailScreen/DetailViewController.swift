//
//  DetailViewController.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 28.08.2023.
//

import UIKit

class DetailViewController: UIViewController {
    var advertisement: Advertisement?
    private let viewItems = DetailViewItemsCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .background
        navigationSetUp()
        imageSetUp()
        generalPanelSetUp()
        print(advertisement)
    }
    func navigationSetUp() {
        navigationController?.navigationBar.tintColor = .label
        
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItems = [shareButton, favoriteButton]
    }
    func imageSetUp() {
        loadImage()
        view.addSubview(viewItems.image)
        NSLayoutConstraint.activate([
            viewItems.image.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            viewItems.image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            viewItems.image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            viewItems.image.heightAnchor.constraint(equalToConstant: 270)
        ])
    }
    func generalPanelSetUp() {
        viewItems.priceLabel.text = advertisement?.price
        viewItems.titleLabel.text = advertisement?.title
        view.addSubview(viewItems.priceLabel)
        
        view.addSubview(viewItems.emailButton)
        view.addSubview(viewItems.callButton)
        view.addSubview(viewItems.titleLabel)
        NSLayoutConstraint.activate([
            viewItems.priceLabel.topAnchor.constraint(equalTo: viewItems.image.bottomAnchor, constant: 10),
            viewItems.priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            viewItems.emailButton.topAnchor.constraint(equalTo: viewItems.image.bottomAnchor, constant: 10),
            viewItems.emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            viewItems.callButton.topAnchor.constraint(equalTo: viewItems.image.bottomAnchor, constant: 10),
            viewItems.callButton.trailingAnchor.constraint(equalTo: viewItems.emailButton.leadingAnchor, constant: -15),
            viewItems.titleLabel.topAnchor.constraint(equalTo: viewItems.priceLabel.bottomAnchor, constant: 15),
            viewItems.titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
        ])
    }
    @objc func favoriteButtonTapped() {
        
    }
    @objc func shareButtonTapped() {
        
    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    private func loadImage() {
        guard let imageURL = advertisement?.imageURL else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.viewItems.image.image = image
                    self.viewItems.image.layer.cornerRadius = 8
                    self.viewItems.image.clipsToBounds = true
                }
            }
        }
    }
}
