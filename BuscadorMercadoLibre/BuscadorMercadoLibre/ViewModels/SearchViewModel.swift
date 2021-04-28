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
        NotificationCenter.default.addObserver(self, selector: #selector(searchResultsReady), name: NSNotification.Name("searchResultsReady"), object: nil)
    }
    
    /// Calls service and performs search with passed query.
    func performSearch(query: String) {
        SearchResultsManager.shared.performSearch(query: query) { (error) in
            // Completion block is only called in error scenario.
        }
    }
    
    @objc func searchResultsReady() {
        self.delegate?.searchResultsReady()
    }
}
