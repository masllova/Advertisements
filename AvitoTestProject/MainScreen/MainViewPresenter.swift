//
//  MainViewPresenter.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import Foundation

protocol MainViewPresenterDelegate: AnyObject {
    func dataDidUpdate()
    func showLoadingIndicator()
    func hideLoadingIndicator()
}


final class MainViewPresenter {
    var advertisements: [Advertisement] = [] {
        didSet {
            delegate?.dataDidUpdate()
        }
    }
    
    func fetchAdvertisementDescription(id: String) {
        guard let url = NetworkManager.urlCreator(for: .detail, idIfNeeded: id) else {
            print("Invalid URL")
            return
        }
        NetworkManager.fetchData(from: url, responseType: Advertisement.self) { [weak self] advertisement, error in
            if let item = advertisement {
                if let index = self?.advertisements.firstIndex(where: { $0.id == id }) {
                    self?.advertisements[index].description = item.description
                    self?.advertisements[index].email = item.email
                    self?.advertisements[index].phoneNumber = item.phoneNumber
                    self?.advertisements[index].address = item.address
                }
            } else if let error = error {
                print("Ошибка при загрузке объявлений: \(error)")
            }
        }
    }
    weak var delegate: MainViewPresenterDelegate?

    func fetchAdvertisements() {
        guard let url = NetworkManager.urlCreator(for: .main, idIfNeeded: nil) else {
            print("Invalid URL")
            return
        }

        delegate?.showLoadingIndicator()

        NetworkManager.fetchData(from: url, responseType: AdvertisementCollection.self) { [weak self] advertisementCollection, error in
            if let advertisements = advertisementCollection?.advertisements {
                self?.advertisements = advertisements
            } else if let error = error {
                print("Ошибка при загрузке объявлений: \(error)")
            }

            self?.delegate?.hideLoadingIndicator() // Скрыть индикатор загрузки
        }
    }
}

enum Filters: String, CaseIterable {
    case recomendation = "Рекомендации"
    case favorities = "Избранное"
    case new = "Новое"
}
