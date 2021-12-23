//
//  EpisodeDetailViewModel.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 22/12/21.
//

import Foundation

protocol EpisodeDetailViewModelDelegate: NSObject {}
protocol EpisodeDetailViewModelProtocol {
    var delegate: EpisodeDetailViewModelDelegate? { get set }
    var episode: Episode { get }
    var tvSeries: TVSeries { get }
}

class EpisodeDetailViewModel: EpisodeDetailViewModelProtocol {
    weak var delegate: EpisodeDetailViewModelDelegate?
    var episode: Episode
    var tvSeries: TVSeries
    
    init(episode: Episode, of tvSeries: TVSeries) {
        self.episode = episode
        self.tvSeries = tvSeries
    }
}
