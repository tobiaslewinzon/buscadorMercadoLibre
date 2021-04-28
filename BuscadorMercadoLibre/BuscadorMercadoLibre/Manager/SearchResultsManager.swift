//
//  SearchResultsManager.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 26/04/2021.
//

import UIKit

/// Manager in charge of gathering, holding and delivering search result items.
class SearchResultsManager {
    // MARK: - Singleton
    /// Shared instance
    static var shared = SearchResultsManager()
    
    // MARK: - Global properties
    /// Holds all available items.
    var items: [Item] = []
    
    let service = SearchResultsService()
    
    // MARK: - Fetch methods
    /// Calls service to get results with passed query. Analyzes response.
    func performSearch(query: String, completion: @escaping ((MercadoLibreError?) -> Void)) {
        service.perfomSearch(query: query) { (items, error) in
            
            // Check if completion brought errors.
            guard error == nil else {
                // Pass on error and return immediately.
                completion(error)
                return
            }
            
            // Unwrap results and check response is not empty.
            guard let searchResults = items, searchResults.count > 0 else {
                // Empty response path. Skip downloading thumbnails.
                log.info("Call succsesfull, but returned no results.")
                
                DispatchQueue.main.async {
                    self.postResultsReadyNotification()
                }
                return
            }
            
            // Response is succesfull and has items. Download thumnbnails.
            log.info("Received \(searchResults.count) items.")
            self.items = searchResults
            self.getImages()
        }
    }
    
    /// Downloads thumbnails and posts results ready notification when finished.
    func getImages() {
        // Dispatch group to handle concurrent downloads.
        let imagesDispatchGroup = DispatchGroup()
    
        // Iterate through itmes to download each thumbnail.
        for (index, item) in items.enumerated() {
            log.info("Downloading thumbnail \(index + 1) of \(self.items.count).")
            
            // Enter dispatch gropu to perform service call.
            imagesDispatchGroup.enter()
            service.downloadThumbnail(url: item.thumbnail) { (data) in
                
                // Check that data is valid for creating UIImage object.
                guard let imageData = data, UIImage(data: imageData) != nil else {
                    // Error path.
                    log.error("Failed to download thumbnail \(index + 1) of \(self.items.count).")
                    // Exit dispatch group.
                    imagesDispatchGroup.leave()
                    return
                }
                
                // Image data is ready. Add data to current item in array.
                self.items[index].image = data
                log.info("Downloaded thumbnail \(index + 1) of \(self.items.count) succesfully.")
                
                // Leave dispatch group.
                imagesDispatchGroup.leave()
            }
        }
            
        // Operations finished. Notify of completion.
        imagesDispatchGroup.notify(queue: .main) {
            log.info("Finished downloading thumbnails.")
            self.postResultsReadyNotification()
        }
    }
    
    /// Posts results ready notification.
    func postResultsReadyNotification() {
        NotificationCenter.default.post(.readyNotification)
    }
    
    /// Resets manager data.
    static func resetManager() {
        shared = SearchResultsManager()
    }
}
