//
//  SearchResultsManager.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 26/04/2021.
//

import Foundation

/// Manager in charge of gathering, holding and delivering search result items.
class SearchResultsManager {
    // MARK: - Singleton
    /// Shared instance
    static var shared = SearchResultsManager()
    
    // MARK: - Global properties
    /// Holds all available items.
    var items: [Item] = []
    
    // MARK: - Fetch methods
    /// Calls service to get results with passed query. Analyzes response.
    func performSearch(query: String, completion: CompletionHandler? = nil) {
        let service = SearchResultsService()
        service.perfomSearch(query: query) { (items, error) in
            
            defer {
                // Pass on completion.
                completion?(items, error)
            }
            
            // Unwrap results and check response is not empty.
            guard let searchResults = items else {
                log.error("Unable to retrieve results from succesfull call.")
                return
            }
            
            log.info("Received \(searchResults.count) items.")
            self.items = searchResults
        }
    }
}
