//
//  SearchResultsViewController.swift
//  BuscadorMercadoLibre
//
//  Created by Tobias Lewinzon on 25/04/2021.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    // MARK: - Initialization
    init() {
        super.init(nibName: "SearchResultsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - IBoutlets
    @IBOutlet weak var resultsTableView: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup methods
    /// Does general setup and calls individual UI setup methods.
    private func setupUI() {
        // Force light mode.
        overrideUserInterfaceStyle = .light
        // Call individual setup methods.
        setupNavigationBar()
        setupResultsTableView()
    }
    
    /// Sets up right button on navigation bar.
    private func setupNavigationBar() {
        let doneButton =  UIBarButtonItem(title: "Listo", style: .plain, target: self, action: #selector(navigateBack))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    /// Sets up resultsTableView.
    private func setupResultsTableView() {
        resultsTableView.register(UINib(nibName: "SearchResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "searchResultsTableViewCell")
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
    }
    
    // MARK: - Miscellaneous methods
    /// Dismisses view controller.
    @objc func navigateBack() {
        // Reset manager to prepare for a new search.
        SearchResultsManager.resetManager()
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Pushes detail view controller with passed item data.
    func navigateToDetailView(item: Item) {
        let detailViewController = DetailViewController(item: item)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResultsManager.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = SearchResultsManager.shared.items[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultsTableViewCell", for: indexPath) as? SearchResultsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.configureCell(item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get corresponding element from manager.
        let item = SearchResultsManager.shared.items[indexPath.row]
        
        // Navigate to detail view.
        navigateToDetailView(item: item)
    }
}
