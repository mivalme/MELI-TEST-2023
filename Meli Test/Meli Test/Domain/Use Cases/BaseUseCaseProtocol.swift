//
//  BaseUseCaseProtocol.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

protocol BaseUseCaseProtocol {
    var repository: RemoteRepositoryProtocol { get }
}
