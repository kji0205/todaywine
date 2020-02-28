//
//  SearchViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/20.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewControllerBase {
    
    var wines: [Wine] = []
    
    var filteredWineList: [Wine] = []
    var isFiltered = false
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        let searchVC = UISearchController(searchResultsController: nil)
        searchVC.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchVC
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchResultTableView.register(UINib(nibName: "WineCell", bundle: nil), forCellReuseIdentifier: "wineCell")
        
        let jsonDecoder = JSONDecoder()
        guard let wineData : NSDataAsset = NSDataAsset(name: "wine") else {
            return
        }
        do {
            self.wines = try jsonDecoder.decode([Wine].self, from: wineData.data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension SearchViewController: UITableViewDelegate {

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch isFiltered {
        case true:
            return filteredWineList.count
        case false:
            return wines.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wineCell") as! WineCell
        
        switch isFiltered {
        case true:
            cell.wineLabel.text = filteredWineList[indexPath.row].name
        case false:
            cell.wineLabel.text = wines[indexPath.row].name
        }
        
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let hasText = searchController.searchBar.text?.lowercased() {
            if hasText.isEmpty {
                isFiltered = false
            } else {
                isFiltered = true
                
//                filteredWineList = wines.filter({ (element) -> Bool in
//                    return element.name.contains(hasText)
//                })
                
                filteredWineList = wines.filter({ $0.name.lowercased().contains(hasText)})
            }
            searchResultTableView.reloadData()
        }
    }
}
