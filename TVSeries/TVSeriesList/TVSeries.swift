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

struct Schedule: Decodable {
    let time: String
    let days: [String]
}

struct ImageSize: Decodable {
    let medium: String
    let original: String
}

struct TVSeriesSearch: Decodable {
    let show: TVSeries
}

struct Episode: Decodable {
    let id: Int
    let number: Int
    let season: Int
    let name: String
    let image: ImageSize?
    let summary: String
}
