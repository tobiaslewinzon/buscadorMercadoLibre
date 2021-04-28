//
//  DetailViewController.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 28/04/2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var soldQuantityLabel: UILabel!
    @IBOutlet weak var availableQuantityLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var item: Item
    
    init(item: Item) {
        self.item = item
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(item: item)
    }
    
    func setup(item: Item) {
        
        
        // ImageView
        imageView.image = item.image != nil ? UIImage(data: item.image!) : UIImage(named: "placeholder")
        
        // Title
        titleLabel.text = item.title
        
        // Price
        priceLabel.text = "$ \(item.price.withCommas())"
        
        // Shipping
        shippingLabel.isHidden = !item.shipping.freeShipping
        shippingLabel.textColor = .white
        shippingLabel.backgroundColor = UIColor(red: 0, green: 204/255, blue: 102/255, alpha: 1)
        shippingLabel.layer.cornerRadius = 5
        shippingLabel.layer.masksToBounds = true
        shippingLabel.text = "Envio gratis"
        
        // Sold quantity
        soldQuantityLabel.text = "\(item.soldQuantity) vendidos"
        
        // Available quantitu
        availableQuantityLabel.text = "\(item.availableQuantity) disponibles"
        
        // City label
        cityLabel.text = item.address.cityName
    }
}
