//
//  SearchResultsTableViewCell.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 25/04/2021.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var thumbNailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    
    // MARK: - View setup
    /// Fills out cell UI with passed item attributes.
    func configureCell() {
        
    }
}
