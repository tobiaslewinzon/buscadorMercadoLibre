//
//  SearchViewModel.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 25/04/2021.
//

import Foundation

protocol SearchViewModelDelegate {
    func searchResultsReady()
    func searchFailed(errorDescription: String)
}

/// View model for SearchViewController.
class SearchViewModel {
    
    var delegate: SearchViewModelDelegate?
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
        
        // Subscribe to searchResultsReady notification.
        NotificationCenter.default.addObserver(self, selector: #selector(searchResultsReady), name: NSNotification.Name("searchResultsReady"), object: nil)
    }
    
    /// Calls service and performs search with passed query.
    func performSearch(query: String) {
        SearchResultsManager.shared.performSearch(query: query) { (error) in
            log.info("Error received. Informing user.")
            self.delegate?.searchFailed(errorDescription: error.getErrorMessage())
        }
    }
    
    /// Reacts to searchResultsReady notification and calls delegate method searchResultsReady.
    @objc func searchResultsReady() {
        log.info("Results ready. Navigating to search results list.")
        self.delegate?.searchResultsReady()
    }
}
