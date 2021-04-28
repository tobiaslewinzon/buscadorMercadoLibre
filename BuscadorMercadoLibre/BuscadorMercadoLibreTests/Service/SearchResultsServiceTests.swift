//
//  SearchResultsServiceTests.swift
//  BuscadorMercadoLibreTests
//
//  Created by Tobias Lewinzon on 28/04/2021.
//

import XCTest
import OHHTTPStubs
@testable import BuscadorMercadoLibre

class SearchResultsServiceTests: XCTestCase {
    
    override func setUp() {
        HTTPStubs.removeAllStubs()
    }
    
    /// Tests reaction to succesfull call.
    func testServiceSuccsesfull() {
        setupStubsSuccsesfull()
        let service = SearchResultsService()
        
        let resultsFetched = expectation(description: "Results fetched")
        
        service.perfomSearch(query: "macbook") { (items, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            XCTAssertEqual(items?.count ?? 0, 20)
            resultsFetched.fulfill()
        }
        
        wait(for: [resultsFetched], timeout: 5)
    }
    
    /// Tests reaction to failed call.
    func testServiceFailure() {
        setupStubsError()
        let service = SearchResultsService()
        
        let resultsFetched = expectation(description: "Results fetched")
        
        service.perfomSearch(query: "macbooj") { (items, error) in
            XCTAssertNil(items)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .serverError)
            
            resultsFetched.fulfill()
        }
        
        wait(for: [resultsFetched], timeout: 5)
    }
    
    /// Sets up succesfull response.
    func setupStubsSuccsesfull() {
        stub(condition: isHost("api.mercadolibre.com"), response: { _ in
            guard let fileAtPath = OHPathForFile("queryResponse.json", type(of: self)) else { return HTTPStubsResponse() }

            return HTTPStubsResponse(
                fileAtPath: fileAtPath,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        })
    }
    
    /// Sets up empty resposnse.
    func setupStubsError() {
        stub(condition: isHost("api.mercadolibre.com")) { (_) -> HTTPStubsResponse in
            return HTTPStubsResponse()
        }
    }
}
