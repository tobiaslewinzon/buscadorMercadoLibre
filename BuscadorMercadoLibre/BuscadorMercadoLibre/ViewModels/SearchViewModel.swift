//
//  SearchViewModel.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 25/04/2021.
//

import Foundation

protocol SearchViewModelDelegate {
    func searchResultsReady()
    func searchFailed()
}

/// View model for SearchViewController.
class SearchViewModel {
    
    var delegate: SearchViewModelDelegate?
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
    }
    
    /// Calls service and performs search with passed query.
    func performSearch(query: String) {
        delegate?.searchResultsReady()
    }
    
}
