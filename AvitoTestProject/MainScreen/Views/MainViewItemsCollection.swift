//
//  MainViewItemsCollection.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import UIKit

class MainViewItemsCollection {
    let horizontalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return view
    } ()
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Поиск"
        view.searchBarStyle = .minimal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let cartButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "cart"), for: .normal)
        view.tintColor = .support
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 27).isActive = true
        return view
    } ()
    let scrollView: UIScrollView = {
       let view = UIScrollView()
        view.backgroundColor = .base
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let filterButtons: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 15
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    func createFilterButton(text: String) -> UIButton {
        let view = UIButton()
        view.setTitle(text, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 19)
        view.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        view.backgroundColor = .subLabel
        view.tintColor = .support
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .background
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .support
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
}
