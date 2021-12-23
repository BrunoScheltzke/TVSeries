//
//  String.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 22/12/21.
//

import Foundation

extension String {
    var htmlStripped: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string

        return decoded ?? self
    }
}
