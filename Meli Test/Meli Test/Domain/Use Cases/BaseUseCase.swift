//
//  BaseUseCase.swift
//  Meli Test
//
//  Created by Miguel Valcárcel on 17/05/23.
//

import Foundation

class BaseUseCase: BaseUseCaseProtocol {    
    let repository: RemoteRepositoryProtocol
    
    public init(repository: RemoteRepositoryProtocol = RemoteRepository()) {
        self.repository = repository
    }
}
