//
//  TVSeriesViewModel.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 21/12/21.
//

import Foundation

protocol TVSeriesViewModelDelegate: NSObject {
    func failed(message: String)
    func didUpdateTVSeriesListWithItems(atRows rows: [Int])
    func didGet(_ filteredTVSeries: [TVSeries])
}

protocol TVSeriesViewModelProtocol {
    var delegate: TVSeriesViewModelDelegate? { get set }
    var tvSeriesList: [TVSeries] { get set }
    func getTVSeries()
    func searchTVSeries(search: String)
}

class TVSeriesViewModel: TVSeriesViewModelProtocol {
    weak var delegate: TVSeriesViewModelDelegate?
    private let apiService: APIServiceProtocol
    var tvSeriesList: [TVSeries] = []
    
    /// manages the pagination index to fetch tv series
    private var pagination = 0
    /// avoids performing an extra call if one is in place
    private var isFetchingTvSeries: Bool = false
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func getTVSeries() {
        guard !isFetchingTvSeries else { return }
        isFetchingTvSeries = true
        apiService.fetchTVSeries(pagination: pagination) { result in
            switch result {
            case .success(let tvSeries):
                // increases pagination count for future request
                self.pagination += 1
                self.isFetchingTvSeries = false
                self.tvSeriesList.append(contentsOf: tvSeries)
                let rowsToUpdate = self.getRowsToUpdate(from: tvSeries)
                self.delegate?.didUpdateTVSeriesListWithItems(atRows: rowsToUpdate)
            case .failure(let error):
                self.delegate?.failed(message: error.localizedDescription)
            }
        }
    }
    
    func searchTVSeries(search: String) {
        apiService.searchTVSeries(search: search) { result in
            switch result {
            case .success(let searchResult):
                self.delegate?.didGet(searchResult.map { $0.show })
            case .failure(let error):
                self.delegate?.failed(message: error.localizedDescription)
            }
        }
    }
    
    /// Calculate rows that collection view needs to reload based on new tvseries
    private func getRowsToUpdate(from newList: [TVSeries]) -> [Int] {
        let startIndex = tvSeriesList.count - newList.count
        let endIndex = startIndex + newList.count
        return Array(startIndex..<endIndex)
    }
}
