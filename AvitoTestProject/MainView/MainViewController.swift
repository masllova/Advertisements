//
//  MainViewController.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import UIKit

class MainViewController: UIViewController, MainViewPresenterDelegate {
    private let presenter: MainViewPresenter!
    var loadingIndicator: UIActivityIndicatorView!
    
    init(with presenter: MainViewPresenter!) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        setupLoadingIndicator()
        setupCollectionView()
        presenter.delegate = self
        presenter.fetchAdvertisements()
    }
    
    func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.color = .black
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func showLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.startAnimating()
        }
    }

    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.loadingIndicator.isHidden = true
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }
    
    func dataDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.advertisements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let advertisement = presenter.advertisements[indexPath.item]
        
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = advertisement.title
        label.numberOfLines = 0
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 30
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: 50)
    }
}
