//
//  TVSeries.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 21/12/21.
//

import Foundation

struct TVSeries: Decodable {
    let id: Int
    let name: String
    let premiered: String?
    let officialSite: String?
    let image: ImageSize?
    let genres: [String]
    let schedule: Schedule
    let summary: String?
}
