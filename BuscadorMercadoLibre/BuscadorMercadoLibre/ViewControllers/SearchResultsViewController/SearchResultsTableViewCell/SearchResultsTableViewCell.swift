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
    func configureCell(item: Item) {
        // Title label
        titleLabel.text = item.title
        // Price label
        priceLabel.text = "$ \(item.price.withCommas())"
        
        // Shipping label
        shippingLabel.isHidden = !item.shipping.freeShipping
        shippingLabel.textColor = .white
        shippingLabel.backgroundColor = UIColor(red: 0, green: 204/255, blue: 102/255, alpha: 1)
        shippingLabel.layer.cornerRadius = 5
        shippingLabel.layer.masksToBounds = true
        shippingLabel.text = "Envio gratis"
        
        // Thumbnail ImageView
        thumbNailImageView.layer.cornerRadius = 5
        thumbNailImageView.layer.masksToBounds = true
        let image = item.image != nil ? UIImage(data: item.image!) : UIImage(named: "placeholder")
        thumbNailImageView.image = image
    }
}
