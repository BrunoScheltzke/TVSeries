//
//  Schedule.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 23/12/21.
//

import Foundation

struct Schedule: Decodable {
    let time: String
    let days: [String]
}
