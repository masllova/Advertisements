//
//  NetworkManager.swift
//  AvitoTestProject
//
//  Created by Александра Маслова on 27.08.2023.
//

import Foundation


class NetworkManager {
    static func fetchData<T: Codable>(from url: URL, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: -1, userInfo: nil))
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(responseType, from: data)
                completion(responseData, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    static func urlCreator (for path: URLs, idIfNeeded id: String?) -> URL? {
        switch path {
        case .main:
            return URL(string: "https://www.avito.st/s/interns-ios/main-page.json")
        case .detail:
            if let id = id {
                return URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json")
            }
        }
        return nil
    }
    
    enum URLs {
        case main
        case detail
    }
}
