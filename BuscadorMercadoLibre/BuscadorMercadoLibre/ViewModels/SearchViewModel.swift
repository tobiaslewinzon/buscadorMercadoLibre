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
    }
    
    /// Calls service and performs search with passed query.
    func performSearch(query: String) {
        SearchResultsManager.shared.performSearch(query: query) { (item, error) in
            
            guard let error = error else {
                // Success path
                self.delegate?.searchResultsReady()
                return
            }

            // Error path.
            self.delegate?.searchFailed(errorDescription: "\(error.getErrorMessage())")
        }
    }
}
