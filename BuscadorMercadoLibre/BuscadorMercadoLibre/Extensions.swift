//
//  Extensions.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 24/04/2021.
//

import UIKit

// MARK: - UIColor extension
extension UIColor {
    /// MercaoLibre standard blue color.
    class var mercadolibreBlue: UIColor {
        return UIColor(displayP3Red: 52/255, green: 131/255, blue: 250/266, alpha: 1.0)
    }
}

// MARK: - UIViewController extension
// Extension for UIViewController.
extension UIViewController {
    /// Returns whether the screen is portrait.
    func isPortrait() -> Bool {
        return self.view.frame.width < self.view.frame.height
    }
}

// MARK: - UIView extension
extension UIView {
    /// Returns the frame of the view relative to the top ViewController.
    func getGlobalFrame() -> CGRect {
        // Get top ViewController view. From https://stackoverflow.com/questions/26667009/get-top-most-uiviewcontroller
        guard let rootViewController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, let strongSuperview = self.superview else {
            print("Error: Unable to get needed data to convert coordinate system. Returning original frame.")
            return self.frame
        }
        
        // Convert frame from current coordinate system to rootView system.
        return strongSuperview.convert(self.frame, to: rootViewController)
    }
}
