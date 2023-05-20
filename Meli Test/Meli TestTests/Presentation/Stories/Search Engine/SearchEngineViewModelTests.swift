//
//  SearchEngineViewModelTests.swift
//  Meli TestTests
//
//  Created by Miguel Valcárcel on 19/05/23.
//

import XCTest
@testable import Meli_Test

final class SearchEngineViewModelTests: XCTestCase {
    var mockBaseService: MockBaseService!
    var mockRepository: RemoteRepositoryProtocol!
    var mockSitesUseCase: SitesUseCaseProtocol!
    var sut: SearchEngineViewModel!
    
    override func setUp() {
        super.setUp()
        mockBaseService = MockBaseService()
        mockRepository = MockRepository(service: mockBaseService)
        mockSitesUseCase = SitesUseCase(repository: mockRepository)
        sut = SearchEngineViewModel(sitesUseCase: mockSitesUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        mockBaseService = nil
        mockRepository = nil
        mockSitesUseCase = nil
        sut = nil
    }
    
    func test_getCategories_success() {
        // Given
        mockBaseService.mockResponse = [MockService(endpoint: DataConstants.Endpoint.categories.url) : .success(jsonFile: "getCategories_success")]
        
        var publishedCategories: [ProductCategory]?
        observe(sut.$categories) { publishedCategories = $0 }
        
        // When
        sut.getCategories()
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertEqual(publishedCategories?.count, 32)
    }
    
    func test_getCategories_failure() {
        // Given
        mockBaseService.mockResponse = [MockService(endpoint: DataConstants.Endpoint.categories.url) : .failure(message: String())]
        
        var publishedCategories: [ProductCategory]?
        observe(sut.$categories, shouldExecute: false) { publishedCategories = $0 }
        
        var publishedToastConfig: Toast.Config?
        observe(sut.$toastConfig) { publishedToastConfig = $0 }
        
        var publishedShowToast: Bool?
        observe(sut.$showToast) { publishedShowToast = $0 }
        
        // When
        sut.getCategories()
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNil(publishedCategories)
        XCTAssertEqual(publishedToastConfig?.type, .error)
        XCTAssertEqual(publishedToastConfig?.message, MeliLocalizables.errorDefaultMessage)
        XCTAssertEqual(publishedShowToast, true)
    }
    
    func test_getCategories_noInternetConnection() {
        // Given
        mockBaseService.mockResponse = [MockService(endpoint: DataConstants.Endpoint.categories.url) : .notConnectedToInternet]
        
        var publishedCategories: [ProductCategory]?
        observe(sut.$categories, shouldExecute: false) { publishedCategories = $0 }
        
        var publishedToastConfig: Toast.Config?
        observe(sut.$toastConfig) { publishedToastConfig = $0 }
        
        var publishedShowToast: Bool?
        observe(sut.$showToast) { publishedShowToast = $0 }
        
        // When
        sut.getCategories()
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNil(publishedCategories)
        XCTAssertEqual(publishedToastConfig?.type, .error)
        XCTAssertEqual(publishedToastConfig?.message, MeliLocalizables.noInternetConnectionMessage)
        XCTAssertEqual(publishedShowToast, true)
    }
    
    func test_searchProduct_success_withQuery() {
        // Given
        sut.searchText = "search test"
        
        let url = DataConstants.Endpoint.search.url + "?q=" + sut.searchText
        mockBaseService.mockResponse = [MockService(endpoint: url) : .success(jsonFile: "searchProduct_success")]
        
        var publishedProducts: [Product]?
        observe(sut.$products, drop: 2) { publishedProducts = $0 }
        
        // When
        sut.searchProduct()
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertEqual(publishedProducts?.count, 50)
    }
    
    func test_searchProduct_success_withCategory() {
        // Given
        sut.searchText = "search test"
        let categoryId = "categoryTest"
        
        let url = DataConstants.Endpoint.search.url + "?category=\(categoryId)&q="
        mockBaseService.mockResponse = [MockService(endpoint: url) : .success(jsonFile: "searchProduct_success")]
        
        var publishedProducts: [Product]?
        observe(sut.$products, drop: 2) { publishedProducts = $0 }
        
        // When
        sut.searchProduct(categoryId: categoryId)
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertEqual(publishedProducts?.count, 50)
        XCTAssertEqual(sut.searchText, "")
    }
    
    func test_searchProduct_failure() {
        // Given
        sut.searchText = "search test"
        
        let url = DataConstants.Endpoint.search.url + "?q=" + sut.searchText
        mockBaseService.mockResponse = [MockService(endpoint: url) : .failure(message: String())]
        
        var publishedProducts: [Product]?
        observe(sut.$products, shouldExecute: false, drop: 2) { publishedProducts = $0 }
        
        var publishedToastConfig: Toast.Config?
        observe(sut.$toastConfig) { publishedToastConfig = $0 }
        
        var publishedShowToast: Bool?
        observe(sut.$showToast) { publishedShowToast = $0 }
        
        // When
        sut.searchProduct()
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNil(publishedProducts)
        XCTAssertEqual(publishedToastConfig?.type, .error)
        XCTAssertEqual(publishedToastConfig?.message, MeliLocalizables.errorDefaultMessage)
        XCTAssertEqual(publishedShowToast, true)
    }
    
    func test_searchProduct_noInternetConnection() {
        // Given
        sut.searchText = "search test"
        
        let url = DataConstants.Endpoint.search.url + "?q=" + sut.searchText
        mockBaseService.mockResponse = [MockService(endpoint: url) : .notConnectedToInternet]
        
        var publishedProducts: [Product]?
        observe(sut.$products, shouldExecute: false, drop: 2) { publishedProducts = $0 }
        
        var publishedToastConfig: Toast.Config?
        observe(sut.$toastConfig) { publishedToastConfig = $0 }
        
        var publishedShowToast: Bool?
        observe(sut.$showToast) { publishedShowToast = $0 }
        
        // When
        sut.searchProduct()
        
        // Then
        waitForExpectations(timeout: 5)
        XCTAssertNil(publishedProducts)
        XCTAssertEqual(publishedToastConfig?.type, .error)
        XCTAssertEqual(publishedToastConfig?.message, MeliLocalizables.noInternetConnectionMessage)
        XCTAssertEqual(publishedShowToast, true)
    }
}
