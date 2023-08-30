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
        view.setImage(UIImage(systemName: "phone")?.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
        view.tintColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let emailButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "envelope")?.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
        view.tintColor = .label
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
        view.font = .boldSystemFont(ofSize: 19)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .support
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 13)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return view
    } ()
    let addressLabel: UILabel = {
        let view = UILabel()
        view.textColor = .support
        view.font = .systemFont(ofSize: 15)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .support
        view.font = .boldSystemFont(ofSize: 13)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let backAdvertisementView: UIView = {
        let view = UIView()
        view.backgroundColor = .base
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let backMapView: UIView = {
        let view = UIView()
        view.backgroundColor = .base
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    let buyButton: UIButton = {
        let view = UIButton()
        view.setTitle("Добавить в корзину", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 19)
        view.contentEdgeInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        view.backgroundColor = .subLabel
        view.tintColor = .support
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
}
