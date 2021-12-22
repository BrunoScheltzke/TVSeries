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
    let premiered: String
    let officialSite: String?
    let image: ImageSize?
}

struct ImageSize: Decodable {
    let medium: String
    let original: String
}
