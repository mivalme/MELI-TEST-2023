//
//  Integer.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 19/05/23.
//

import Foundation

extension Int {
    var withFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let formattedString = formatter.string(for: self)
        return formattedString ?? String()
    }
}
