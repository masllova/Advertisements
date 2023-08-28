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
        navigationController?.navigationBar.tintColor = .label
        
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItems = [shareButton, favoriteButton]
    }
    
    @objc func favoriteButtonTapped() {
        
    }
    @objc func shareButtonTapped() {

    }
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
