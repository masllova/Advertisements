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
        view.spacing = 10
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let textField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .gray
        view.placeholder = "search"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let magnifyIcon: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let crossIcon: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "xmark"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let cartIcon: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "cart"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    func createCategoryTitle(text: String) -> UILabel {
        let view = UILabel()
        view.text = text
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
}
