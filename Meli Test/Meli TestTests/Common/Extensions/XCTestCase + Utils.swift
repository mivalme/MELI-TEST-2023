//
//  XCTestCase + Utils.swift
//  Meli TestTests
//
//  Created by Miguel Valcárcel on 19/05/23.
//

import XCTest
import Combine

extension XCTestCase {
    func observe<T: Any>(_ propertyPublisher: Published<T>.Publisher,
                         shouldExecute: Bool = true,
                         drop: Int = 1,
                         completed: @escaping (T) -> Void) {
        let expectation = expectation(description: "Awaiting value")
        expectation.isInverted = !shouldExecute
        
        var cancellable: AnyCancellable?
        
        cancellable = propertyPublisher
            .dropFirst(drop)
            .first()
            .sink { value in
                completed(value)
                cancellable?.cancel()
                expectation.fulfill()
            }
    }
}
