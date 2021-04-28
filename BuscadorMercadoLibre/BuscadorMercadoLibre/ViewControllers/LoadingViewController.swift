//
//  LoadingViewController.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 28/04/2021.
//

import UIKit

/// Loading indicator in the center of the screen.
class LoadingVewController: UIViewController {
    
    override func viewDidLoad() {
        
        // Configure opacity of view, so presenter VC can be seen.
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        // Configure
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Start animating immediatelty.
        indicator.startAnimating()
        view.addSubview(indicator)
        
        // Center/
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
