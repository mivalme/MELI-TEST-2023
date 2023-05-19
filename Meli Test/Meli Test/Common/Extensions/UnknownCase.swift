//
//  UnknownCase.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 18/05/23.
//

import Foundation

protocol UnknownCase: RawRepresentable, CaseIterable where RawValue: Equatable & Codable {
    static var unknown: Self { get }
}

extension UnknownCase {
    init(rawValue: RawValue) {
        let value = Self.allCases.first { $0.rawValue == rawValue }
        self = value ?? Self.unknown
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        let value = Self(rawValue: rawValue)
        self = value ?? Self.unknown
    }
}
