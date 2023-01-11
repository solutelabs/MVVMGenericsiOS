//
//  ViewController.swift
//  MVVMGenerics
//  Created by pramit D on 02/01/23.

import UIKit
import SDWebImage
class ViewController: UIViewController, UISearchBarDelegate {
    let searchViewModel = AppsSearchViewModel()
    @IBOutlet weak var searchBar: UISearchBar!
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    @IBOutlet weak var tblProduct: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseViewController()
    }
    func initialiseViewController() {
        setupSearchViewModelObserver()
        setupLoadingIndicator()
        registerCell()
    }
    fileprivate func registerCell() {
        let tVCell = UINib(nibName: "ProductSearchCell", bundle: nil)
        tblProduct.register(tVCell, forCellReuseIdentifier: "ProductSearchCell")
    }
    fileprivate func setupSearchViewModelObserver() {
        searchViewModel.appResults.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.tblProduct.reloadData()
            }
        }
        searchViewModel.isSearching.bind { [weak self] (isSearching) in
            guard let isSearching = isSearching else { return }
            DispatchQueue.main.async {
                isSearching ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.startAnimating()
                self?.loadingIndicator.isHidden = !isSearching
            }
        }
    }
    fileprivate func setupLoadingIndicator() {
        loadingIndicator.color = .lightGray
        loadingIndicator.center = self.view.center
        self.view.addSubview(loadingIndicator)
        //loadingIndicator.centerInSuperview(size: .init(width: 60, height: 60))
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchViewModel.performSearch(searchText)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.appResults.value?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSearchCell") as! ProductSearchCell
        cell.appResult = searchViewModel.appResults.value?[indexPath.item]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 288
    }
}
