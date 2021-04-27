//
//  SearchResultsService.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 25/04/2021.
//

import Foundation
import Alamofire

// MARK: - Completion and error handlers
typealias CompletionHandler = ([Item]?, MercadoLibreError?) -> Void

// MARK: - Custom errors
enum MercadoLibreError {
    case serverError, networkError, decodingError
    
    /// Returns custom error message for each error type.
    func getErrorMessage() -> String {
        switch self {
        case .serverError, .decodingError:
            return "Error en la búsqueda, intente nuevamente."
        case .networkError:
            return "Revise su conxión a internet e intente nuevamente."
        }
    }
}

// MARK: - SearchResultsService
class SearchResultsService {
    /// Standard URL for search with query. From https://developers.mercadolibre.com.ar/es_ar/items-y-busquedas#Obtener-%C3%ADtems-de-una-consulta-de-b%C3%BAsqueda
    let url = "https://api.mercadolibre.com/sites/MLA/search?"
    
    /// Performs GET request.
    func perfomSearch(query: String, completion: @escaping CompletionHandler) {
        // Prepare parameters.
        let limit = 20
        let parameters: Parameters = ["q": query, "limit": limit]
        
        log.info("Attempting service call: \(url)&limit=\(limit)&q=\(query)")
        
        // Perform Alamofire request.
        AF.request(url, parameters: parameters).response { response in
            let decoder = JSONDecoder()
            
            guard let responseData = response.data else {
                // Error path.
                // Check if erorr is due to connectivity.
                let customError: MercadoLibreError = NetworkReachabilityManager()?.isReachable == false ? .networkError : .serverError
                
                // Logging.
                switch customError {
                case .networkError:
                    log.error("Service call failed. Internet connection is offline.")
                case .serverError:
                    let statusCode = response.response?.statusCode != nil ? "\(response.response!.statusCode)" : "Unknown"
                    log.error("Service call failed. Status code: \(statusCode).")
                default:
                    break
                }
                
                // Call completion with error.
                completion(nil, customError)
                return
            }
            
            // Attempt to decode.
            do {
                let response = try decoder.decode(SearchResults.self, from: responseData)
                log.info("Service call successful.")
                // Success decoding path.
                completion(response.results, nil)
            } catch {
                // Error decoding path.
                log.error("Failed to decode resonse. \(error.localizedDescription) ")
                completion(nil, .decodingError)
            }
        }
    }
}
