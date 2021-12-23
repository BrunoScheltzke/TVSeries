//
//  ImageManager.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 22/12/21.
//

import UIKit
import Alamofire
import AlamofireImage

protocol ImageManagerProtocol {
    func fetchImage(imagePath: String, completion: @escaping(Result<UIImage, Error>) -> Void)
}

struct ImageManager: ImageManagerProtocol {
    private init() {}
    static let shared = ImageManager()
    
    // Handles image caching
    private let imageCache = AutoPurgingImageCache()
    
    func fetchImage(imagePath: String, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImg = imageCache.image(withIdentifier: imagePath) {
            completion(.success(cachedImg))
            return
        }
        AF.request(imagePath)
            .validate()
            .responseImage { response in
                switch response.result {
                case .success(let img):
                    self.imageCache.add(img, withIdentifier: imagePath)
                    completion(.success(img))
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
}
