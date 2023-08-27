//
//  MainViewController.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import UIKit

class MainViewController: UIViewController, MainViewPresenterDelegate {
    private let presenter: MainViewPresenter!
    private let viewItems = MainViewItemsCollection()
    
    init(with presenter: MainViewPresenter!) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchPanel()
        setupLoadingIndicator()
        setupCollectionView()
        
        presenter.delegate = self
        presenter.fetchAdvertisements()
    }
// MARK: - methods
    func showLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.viewItems.loadingIndicator.startAnimating()
        }
    }
    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.viewItems.loadingIndicator.stopAnimating()
            self?.viewItems.loadingIndicator.isHidden = true
        }
    }
    func dataDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.viewItems.collectionView.reloadData()
        }
    }
// MARK: - views
    func setupSearchPanel() {
        view.addSubview(viewItems.horizontalStack)
        NSLayoutConstraint.activate([
            viewItems.horizontalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            viewItems.horizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            viewItems.horizontalStack.heightAnchor.constraint(equalToConstant: 35),
            viewItems.horizontalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
    func setupLoadingIndicator() {
        view.addSubview(viewItems.loadingIndicator)

        NSLayoutConstraint.activate([
            viewItems.loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewItems.loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    func setupCollectionView() {
        viewItems.collectionView.dataSource = self
        viewItems.collectionView.delegate = self
        viewItems.collectionView.register(AdvertisementCell.self, forCellWithReuseIdentifier: "AdvertisementCell")
        view.addSubview(viewItems.collectionView)
       
        NSLayoutConstraint.activate([
            viewItems.collectionView.topAnchor.constraint(equalTo: viewItems.horizontalStack.bottomAnchor, constant: 16),
            viewItems.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewItems.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewItems.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.advertisements.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvertisementCell", for: indexPath) as! AdvertisementCell
        let advertisement = presenter.advertisements[indexPath.item]
        cell.titleLabel.text = advertisement.title
        cell.backgroundColor = .lightGray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 30
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: 50)
    }
}
