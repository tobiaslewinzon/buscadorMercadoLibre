//
//  SearchResultsManagerTests.swift
//  BuscadorMercadoLibreTests
//
//  Created by Tobias Lewinzon on 28/04/2021.
//

import XCTest
import OHHTTPStubs
@testable import BuscadorMercadoLibre

class SearchResultsManagerTests: XCTestCase {
    
    override func setUp() {
        HTTPStubs.removeAllStubs()
        SearchResultsManager.resetManager()
    }
    
    /// Tests manager data after succsesfull items and thumbnails calls.
    func testManagerData() {
        setupStubsSuccsesfullResults()
        setupStubSuccesfullImage()
        
        _ = expectation(forNotification: NSNotification.Name("searchResultsReady"), object: nil, handler: nil)
        
        SearchResultsManager.shared.performSearch(query: "macbook") { _ in
            // Intentionally left blank.
        }
        
        // Wait for searchResultsReady notification.
        waitForExpectations(timeout: 10, handler: nil)
        
        // Test that manager holds expected elements.
        XCTAssertEqual(SearchResultsManager.shared.items.count, 20)
        
        // Tests that images where correctly setup for each item.
        for item in SearchResultsManager.shared.items {
            guard let imageData = item.image else {
                XCTFail("An item does not contain image data")
                return
            }
            
            XCTAssertNotNil(UIImage(data: imageData))
        }
        
        // Test some values of the first item to confirm parsing is correct.
        guard let firstItem = SearchResultsManager.shared.items.first else {
            XCTFail("Unable to retrieve item from manager.")
            return
        }
        
        XCTAssertEqual(firstItem.title, "Macbook Air A1466 Silver 13.3 , Intel Core I5 5350u 8gb De Ram 128gb Ssd, Intel Hd Graphics 6000 1440x900px Macos Sierra 10")
        XCTAssertEqual(firstItem.price, 149999)
        XCTAssertEqual(firstItem.id, "MLA918171240")
        XCTAssertEqual(firstItem.shipping.freeShipping, true)
    }
    
    /// Tests manager data after a failed items call.
    func testManagerFailure() {
        setupStubsError()
        
        SearchResultsManager.shared.performSearch(query: "macbook") { error in
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .serverError)
            XCTAssertTrue(SearchResultsManager.shared.items.isEmpty)
        }
    }
    
    /// Tests manager data afer an empty items response.
    func testManagerEmptyResponse() {
        setupStubsEmptyResults()
        
        _ = expectation(forNotification: NSNotification.Name("searchResultsReady"), object: nil, handler: nil)
        
        SearchResultsManager.shared.performSearch(query: "jqjsusususuuakakajdjdj") { error in
            XCTAssertNil(error)
        }
        
        // Wait for searchResultsReady notification.
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(SearchResultsManager.shared.items.isEmpty)
    }
    
    // MARK: - Stubs setup.
    /// Sets up succesfull response.
    func setupStubsSuccsesfullResults() {
        stub(condition: isHost("api.mercadolibre.com"), response: { _ in
            guard let fileAtPath = OHPathForFile("queryResponse.json", type(of: self)) else { return HTTPStubsResponse() }

            return HTTPStubsResponse(
                fileAtPath: fileAtPath,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        })
    }
    
    func setupStubSuccesfullImage() {
        let stubPath = OHPathForFile("imageResponse.jpg", type(of: self))
        stub(condition: isExtension("png") || isExtension("jpg") || isExtension("gif")) { _ in
            return fixture(filePath: stubPath!, headers: ["Content-Type":"image/jpeg"])
        }
    }
    
    /// Sets up empty resposnse.
    func setupStubsError() {
        stub(condition: isHost("api.mercadolibre.com")) { (_) -> HTTPStubsResponse in
            return HTTPStubsResponse()
        }
    }
    
    /// Sets up stubs empty response.
    func setupStubsEmptyResults() {
        stub(condition: isHost("api.mercadolibre.com"), response: { _ in
            guard let fileAtPath = OHPathForFile("empty.json", type(of: self)) else { return HTTPStubsResponse() }

            return HTTPStubsResponse(
                fileAtPath: fileAtPath,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        })
    }
}
