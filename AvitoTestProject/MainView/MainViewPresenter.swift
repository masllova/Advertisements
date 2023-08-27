//
//  MainViewPresenter.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import Foundation

protocol MainViewPresenterDelegate: AnyObject {
    func dataDidUpdate()
}

final class MainViewPresenter {
    var advertisements: [Advertisement] = [] {
        didSet {
            delegate?.dataDidUpdate()
        }
    }

    weak var delegate: MainViewPresenterDelegate?

    func fetchAdvertisements() {
        guard let url = NetworkManager.urlCreator(for: .main, idIfNeeded: nil) else {
            print("Invalid URL")
            return
        }
        
        NetworkManager.fetchData(from: url, responseType: AdvertisementCollection.self) { [weak self] advertisementCollection, error in
            if let advertisements = advertisementCollection?.advertisements {
                self?.advertisements = advertisements
            } else if let error = error {
                print("Ошибка при загрузке объявлений: \(error)")
            }
        }
    }
}

