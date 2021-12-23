//
//  EpisodeDetailViewController.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 22/12/21.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var viewModel: EpisodeDetailViewModelProtocol
    let imageManager: ImageManagerProtocol

    init(viewModel: EpisodeDetailViewModelProtocol, imageManager: ImageManagerProtocol = ImageManager.shared) {
        self.viewModel = viewModel
        self.imageManager = imageManager
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = viewModel.episode.image {
            imageManager.fetchImage(imagePath: image.original) { [weak self] result in
                guard let self = self else { return }
                if case let .success(img) = result {
                    self.imageView.image = img
                }
            }
        } else {
            imageView.isHidden = true
        }
        nameLabel.text = viewModel.episode.name
        seasonLabel.text = "Season \(viewModel.episode.season)"
        episodeLabel.text = "Episode \(viewModel.episode.number)"
        summaryLabel.text = viewModel.episode.summary.htmlStripped
    }
    
}

extension EpisodeDetailViewController: EpisodeDetailViewModelDelegate {}
