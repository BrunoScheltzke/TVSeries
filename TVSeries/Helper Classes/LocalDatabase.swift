//
//  LocalDatabase.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 23/12/21.
//

import Foundation

protocol LocalDatabaseProtocol {
    func isFavorite(tvSeries: TVSeries) -> Bool
    func getFavorites() -> [TVSeries]
    func toggleFavoriteStatus(for tvSeries: TVSeries)
}

class LocalDatabase: LocalDatabaseProtocol {
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favorites"
    
    func isFavorite(tvSeries: TVSeries) -> Bool {
        let favorites = getFavorites()
        return favorites.contains(where: { $0.id == tvSeries.id })
    }
    
    func getFavorites() -> [TVSeries] {
        return userDefaults.object(with: favoritesKey) ?? []
    }
    
    func toggleFavoriteStatus(for tvSeries: TVSeries) {
        var favorites = getFavorites()
        if favorites.contains(where: { $0.id == tvSeries.id }) {
            favorites.removeAll(where: { $0.id == tvSeries.id } )
        } else {
            favorites.append(tvSeries)
        }
        
        userDefaults.set(object: favorites, forKey: favoritesKey)
    }
}

extension UserDefaults {
    func object<T: Codable>(with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(T.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        self.set(data, forKey: key)
    }
}
