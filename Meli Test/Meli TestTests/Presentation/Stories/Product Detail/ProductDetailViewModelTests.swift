//
//  ProductDetailViewModelTests.swift
//  Meli TestTests
//
//  Created by Miguel Valcárcel on 20/05/23.
//

import XCTest
@testable import Meli_Test

final class ProductDetailViewModelTests: XCTestCase {
    var mockBaseService: MockBaseService!
    var mockRepository: RemoteRepositoryProtocol!
    var mockItemsUseCase: ItemsUseCaseProtocol!
    var sut: ProductDetailViewModel!
    
    override func setUp() {
        super.setUp()
        mockBaseService = MockBaseService()
        mockRepository = MockRepository(service: mockBaseService)
        mockItemsUseCase = ItemsUseCase(repository: mockRepository)
        sut = ProductDetailViewModel(productId: DummyData.productId, itemsUseCase: mockItemsUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        mockBaseService = nil
        mockRepository = nil
        mockItemsUseCase = nil
        sut = nil
    }
    
    func test_fetchProductData_success() {
        // Given
        let url = DataConstants.Endpoint.items.url + "?ids=" + DummyData.productId
        mockBaseService.mockResponse = [MockService(endpoint: url) : .success(jsonFile: "fetchProductData_success")]
        
        var publishedProduct: Product?
        observe(sut.$product) { publishedProduct = $0 }
        
        // When
        sut.fetchProductData()
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(publishedProduct)
        XCTAssertEqual(publishedProduct?.id, "MCO1147430217")
    }
    
    func test_fetchProductData_failure() {
        // Given
        let url = DataConstants.Endpoint.items.url + "?ids=" + DummyData.productId
        mockBaseService.mockResponse = [MockService(endpoint: url) : .failure(message: String())]
        
        var publishedProduct: Product?
        observe(sut.$product, shouldExecute: false) { publishedProduct = $0 }
        
        var publishedToastConfig: Toast.Config?
        observe(sut.$toastConfig) { publishedToastConfig = $0 }
        
        var publishedShowToast: Bool?
        observe(sut.$showToast) { publishedShowToast = $0 }
        
        // When
        sut.fetchProductData()
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNil(publishedProduct)
        XCTAssertEqual(publishedToastConfig?.type, .error)
        XCTAssertEqual(publishedToastConfig?.message, MeliLocalizables.errorDefaultMessage)
        XCTAssertEqual(publishedShowToast, true)
    }
    
    func test_fetchProductData_noInternetConnection() {
        // Given
        let url = DataConstants.Endpoint.items.url + "?ids=" + DummyData.productId
        mockBaseService.mockResponse = [MockService(endpoint: url) : .notConnectedToInternet]
        
        var publishedProduct: Product?
        observe(sut.$product, shouldExecute: false) { publishedProduct = $0 }
        
        var publishedToastConfig: Toast.Config?
        observe(sut.$toastConfig) { publishedToastConfig = $0 }
        
        var publishedShowToast: Bool?
        observe(sut.$showToast) { publishedShowToast = $0 }
        
        // When
        sut.fetchProductData()
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNil(publishedProduct)
        XCTAssertEqual(publishedToastConfig?.type, .error)
        XCTAssertEqual(publishedToastConfig?.message, MeliLocalizables.noInternetConnectionMessage)
        XCTAssertEqual(publishedShowToast, true)
    }
    
    struct DummyData {
        static let productId = "dummyProductId"
    }
}
