//
//  Episode.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 23/12/21.
//

import Foundation

struct Episode: Decodable {
    let id: Int
    let number: Int
    let season: Int
    let name: String
    let image: ImageSize?
    let summary: String?
}
