//
//  FavoriteListViewModel.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 23/12/21.
//

import Foundation

protocol FavoriteListViewModelProtocol {
    func getFavorites() -> [TVSeries]
}

class FavoriteListViewModel: FavoriteListViewModelProtocol {
    private let localDatabase: LocalDatabaseProtocol
    
    init(localDatabase: LocalDatabaseProtocol = LocalDatabase()) {
        self.localDatabase = localDatabase
    }
    
    func getFavorites() -> [TVSeries] {
        return localDatabase.getFavorites()
    }
}
