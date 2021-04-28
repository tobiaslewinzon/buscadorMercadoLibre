//
//  SearchViewControllerTests.swift
//  BuscadorMercadoLibreTests
//
//  Created by Tobias Lewinzon on 24/04/2021.
//

import XCTest
@testable import BuscadorMercadoLibre

class SearchViewControllerTests: XCTestCase {
    var viewController: SearchViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = SearchViewController()
        viewController.viewDidLoad()
        viewController.viewDidAppear(false)
    }
    
    /// Tests search button is enabled when user types in the text field.
    func testSearchButtonChanges() {
        // Typing.
        viewController.searchTextField.text = "Hola"
        viewController.textFieldDidChange(viewController.searchTextField)
        XCTAssertTrue(viewController.searchButton.isEnabled)
        
        // Wipe text.
        viewController.searchTextField.text = ""
        viewController.textFieldDidChange(viewController.searchTextField)
        XCTAssertFalse(viewController.searchButton.isEnabled)
    }
}
