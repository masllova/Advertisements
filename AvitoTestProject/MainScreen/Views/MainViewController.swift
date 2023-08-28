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
    var originalAdvertisements: [Advertisement] = []
    
    init(with presenter: MainViewPresenter!) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .base
        
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
            self?.originalAdvertisements = self?.presenter.advertisements ?? []
        }
    }
    // MARK: - views
    func setupSearchPanel() {
        for text in Filters.allCases {
            viewItems.filterButtons.addArrangedSubview(viewItems.createFilterButton(text: text.rawValue))
        }
        viewItems.scrollView.addSubview(viewItems.filterButtons)
        viewItems.horizontalStack.addArrangedSubview(viewItems.searchBar)
        viewItems.horizontalStack.addArrangedSubview(viewItems.cartButton)
        viewItems.searchBar.delegate = self
        
        view.addSubview(viewItems.scrollView)
        view.addSubview(viewItems.horizontalStack)
        NSLayoutConstraint.activate([
            viewItems.horizontalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            viewItems.horizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            viewItems.horizontalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            viewItems.scrollView.topAnchor.constraint(equalTo: viewItems.horizontalStack.bottomAnchor, constant: 15),
            viewItems.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            viewItems.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            viewItems.scrollView.heightAnchor.constraint(equalToConstant: 44),
            
            viewItems.filterButtons.topAnchor.constraint(equalTo: viewItems.scrollView.topAnchor),
            viewItems.filterButtons.leadingAnchor.constraint(equalTo: viewItems.scrollView.leadingAnchor),
            viewItems.filterButtons.trailingAnchor.constraint(equalTo: viewItems.scrollView.trailingAnchor),
            viewItems.filterButtons.bottomAnchor.constraint(equalTo: viewItems.scrollView.bottomAnchor),
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
            viewItems.collectionView.topAnchor.constraint(equalTo: viewItems.filterButtons.bottomAnchor, constant: 16),
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
        cell.imageURL = advertisement.imageURL
        cell.priceLabel.text = advertisement.price
        cell.locationLabel.text = advertisement.location
        cell.dateLabel.text = advertisement.createdDate
        cell.backgroundColor = .base
        cell.layer.cornerRadius = 11
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 30
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: 240)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let advertisement = presenter.advertisements[indexPath.item]
        presenter.fetchAdvertisementDescription(id: advertisement.id)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.advertisements = originalAdvertisements
        } else {
            presenter.advertisements = originalAdvertisements.filter { $0.title.lowercased().hasPrefix(searchText.lowercased()) }
        }
        viewItems.collectionView.reloadData()
    }
}
