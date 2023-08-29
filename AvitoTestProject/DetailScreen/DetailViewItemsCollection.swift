//
//  DetailViewItemsCollection.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 28.08.2023.
//

import UIKit

class DetailViewItemsCollection {
    let favoriteButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let callButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let emailButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "envelope.fill"), for: .normal)
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let horizontalStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let priceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.font = .boldSystemFont(ofSize: 22)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.font = .systemFont(ofSize: 16)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .support
        view.font = .systemFont(ofSize: 13)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let buyButton: UIButton = {
        let view = UIButton()
        view.setTitle("Добавить в корзину", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 19)
        view.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        view.backgroundColor = .subLabel
        view.tintColor = .support
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
}
