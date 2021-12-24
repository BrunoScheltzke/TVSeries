//
//  TVSeriesDetailViewModel.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 22/12/21.
//

import Foundation

protocol TVSeriesDetailViewModelDelegate: NSObject {
    func failed(message: String)
    func didGet(_ seasons: [Season])
}

protocol TVSeriesDetailViewModelProtocol {
    var delegate: TVSeriesDetailViewModelDelegate? { get set }
    var tvSeries: TVSeries { get }
    func isFavorite() -> Bool
    func getSeasons()
    func toggleFavoriteStatus()
}

class TVSeriesDetailViewModel: TVSeriesDetailViewModelProtocol {
    weak var delegate: TVSeriesDetailViewModelDelegate?
    let tvSeries: TVSeries
    private let apiService: APIServiceProtocol
    private let localDatabase: LocalDatabaseProtocol
    
    init(tvServies: TVSeries,
         apiService: APIServiceProtocol = APIService(),
         localDatabase: LocalDatabaseProtocol = LocalDatabase()) {
        self.localDatabase = localDatabase
        self.tvSeries = tvServies
        self.apiService = apiService
    }
    
    func getSeasons() {
        apiService.getEpisodes(forTVSeriesId: tvSeries.id) { result in
            switch result {
            case .success(let episodes):
                let groupedEpisodes = Dictionary(grouping: episodes, by: { $0.season })
                var seasons = groupedEpisodes.map { Season(name: "Sesason \($0.key)", episodes: $0.value) }
                seasons.sort(by: { $0.name < $1.name })
                self.delegate?.didGet(seasons)
            case .failure:
                self.delegate?.failed(message: "Failed to get episode list. Try again later.")
            }
        }
    }
    
    func isFavorite() -> Bool {
        localDatabase.isFavorite(tvSeries: tvSeries)
    }
    
    func toggleFavoriteStatus() {
        localDatabase.toggleFavoriteStatus(for: tvSeries)
    }
}
