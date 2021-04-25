//
//  SearchViewController.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 24/04/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Initialization
    init() {
        super.init(nibName: "SearchViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var containerViewTopAnchor: NSLayoutConstraint!
    @IBOutlet var containerViewCenterYAnchor: NSLayoutConstraint!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotifications()
        setupTapGestureRecognizer()
    }
    
    // MARK: - Setup methods
    /// Setup tap gesture recognizer.
    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    /// Subscribes to notifications.
    private func setupNotifications() {
        // Subscribe to device orientation change notification.
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        // Subscribe to keyboard showing notification.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Subscribe to keyboard hiding notification.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Does general setup and calls individual UI setup methods.
    private func setupUI() {
        // Force light mode.
        overrideUserInterfaceStyle = .light
        setupContainerViewConstraints()
        setupSearchTextField()
        setupSearchButton()
    }
    
    /// Sets up container view constraints depending on device orientation.
    private func setupContainerViewConstraints() {
        // Get device orientation.
        let isPortrait = self.isPortrait()
        
        // Anchor the view closer to the top for portrait orientation, and center it for landscape.
        containerViewCenterYAnchor.isActive = !isPortrait
        containerViewTopAnchor.isActive = isPortrait
    }
    
    /// Sets up search text field.
    private func setupSearchTextField() {
        searchTextField.delegate = self
        searchTextField.placeholder = "Buscar productos, marcas y más..."
        
        // React to text changes.
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    /// Sets up search button.
    private func setupSearchButton() {
        // Setup colors.
        searchButton.tintColor = .white
        searchButton.backgroundColor = .mercadolibreBlue
        
        // Setup corner radius.
        searchButton.layer.cornerRadius = 5
        searchButton.layer.masksToBounds = true
        
        // Setup initial state as disabeld.
        searchButton.isEnabled = false
    }
    
    // MARK: - Listener methods
    /// Reacts to device orientation change.
    @objc func orientationDidChange() {
        setupContainerViewConstraints()
    }
    
    /// Reacts to keyboard showing.
    @objc func keyboardWillShow(notification: NSNotification) {
        
        // On landscape orientation, ensure views remain visible above keybopard.
        guard !self.isPortrait(),
              let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              self.view.frame.origin.y == 0 else {
            return
        }
        
        // Get visible screen frame. Substract keyboard height from the whole screen height.
        let visibleFrameHeight = UIScreen.main.bounds.height - keyboardSize.height
        
        // Get how high the keyboard is overlapping the views.
        let overlapping = searchButton.getGlobalFrame().maxY - visibleFrameHeight
        
        // Ensure there is overlap before performing changes.
        guard overlapping > 0 else { return }
        
        // Shift view up with a slight offset.
        self.view.frame.origin.y -= overlapping + 15
    }

    /// Reacts to keyboard hiding.
    @objc func keyboardWillHide(notification: NSNotification) {
        // Restore view origin.
        self.view.frame.origin.y = 0
    }
    
    /// Reacts to text field text changing. Enables or disables search button if text is empty.
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        searchButton.isEnabled = text != ""
    }
    
    /// Reacts to tap on the screen. Hides keyboard.
    @objc func handleTap() {
        searchTextField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    
}
