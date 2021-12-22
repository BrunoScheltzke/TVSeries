//
//  TVSeriesViewModel.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 21/12/21.
//

import Foundation

protocol TVSeriesViewModelDelegate: NSObject {
    func failed(message: String)
    func didGet(_ tvSeries: [TVSeries])
}

protocol TVSeriesViewModelProtocol {
    var delegate: TVSeriesViewModelDelegate? { get set }
    func getTVSeries()
}

class TVSeriesViewModel: TVSeriesViewModelProtocol {
    weak var delegate: TVSeriesViewModelDelegate?
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func getTVSeries() {
        apiService.fetchTVSeries(pagination: 0) { result in
            switch result {
            case .success(let tvSeries):
                self.delegate?.didGet(tvSeries)
            case .failure(let error):
                self.delegate?.failed(message: error.localizedDescription)
            }
        }
    }
}
