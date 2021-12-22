//
//  TVSeriesCollectionViewCell.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 22/12/21.
//

import UIKit

class TVSeriesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var imageManager: ImageManagerProtocol = ImageManager.shared
    
    var tvSeries: TVSeries? {
        didSet {
            guard let tvSeries = tvSeries else { return }
            if let image = tvSeries.image {
                fetchImage(imagePath: image.medium)
            }
        }
    }
    
    private func fetchImage(imagePath: String) {
        imageManager.fetchImage(imagePath: imagePath) { [weak self] result in
            guard let self = self else { return }
            if case let .success(img) = result {
                self.imageView.image = img
            }
        }
    }
}
