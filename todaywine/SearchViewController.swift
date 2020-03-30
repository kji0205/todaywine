//
//  SearchViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/20.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit


class SearchViewController: UIViewControllerBase, UISearchBarDelegate {
    
    var wines: [Wine] = []
    
    var filteredWineList: [Wine] = []
    var isFiltered = false
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var searchResultTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK:- Search Log
    var search : [SearchLog] = []
    var store = DataStore.sharedInstance
    
    private let fileURL: URL = {
        let documentDirectoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.appendingPathComponent("searchlog.archive")
    }()
    
    // MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.tableHeaderView = searchBar
        searchResultTableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
        searchBar.placeholder = "Input wine name"
        
        searchVC.searchResultsUpdater = self
        searchVC.obscuresBackgroundDuringPresentation = false
        searchVC.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.searchController = searchVC
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = false
        
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
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let hasText = searchBar.text?.lowercased() {
            if hasText.isEmpty {
                isFiltered = false
            } else {
                isFiltered = true
                filteredWineList = wines.filter({ $0.name.lowercased().contains(hasText)})
                
            }
            searchResultTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let hasText = searchBar.text?.lowercased() {
            if hasText.isEmpty {
                isFiltered = false
            } else {
                isFiltered = true
                filteredWineList = wines.filter({ $0.name.lowercased().contains(hasText)})
                
                save(filteredWineList.count > 1, hasText)
            }
            searchResultTableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        if searchVC.isActive{
//            searchVC.isActive = false
//        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.searchTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        self.view.endEditing(true)
//        searchBar.searchTextField.resignFirstResponder()
    }

    // MARK:- save
    func save(_ result: Bool, _ searchKeyword: String) {

        let _searchLog = SearchLog.init(searchKeyword: searchKeyword, regdate: Date(), result: result)

        self.store.searchLogs.append(_searchLog)

        do {
            let _searchLogData = try NSKeyedArchiver.archivedData(withRootObject: self.store.searchLogs, requiringSecureCoding: false)
            UserDefaults.standard.set(_searchLogData, forKey: "SearchLog")
          
        } catch  {
            print(error)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if searchVC.isActive{
            searchVC.isActive = false
        }
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "SearchResultViewController") as? SearchResultViewController else { return }
        
        vc.wineDataIndex = indexPath.row
        vc._name = wines[indexPath.row].name
        if let region = wines[indexPath.row].region {
            vc._region = region
        }
        if let grapes = wines[indexPath.row].grapes {
            vc._grapes = grapes
        }
        vc._country = wines[indexPath.row].country
        if let description = wines[indexPath.row].description {
            vc._description = description
        }
        
        save(true, wines[indexPath.row].name)
        
        present(vc, animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let hasText = searchController.searchBar.text?.lowercased() {
            if hasText.isEmpty {
                isFiltered = false
                save(false, hasText)
            } else {
                isFiltered = true
                
                filteredWineList = wines.filter({ $0.name.lowercased().contains(hasText)})
                
                save(filteredWineList.count > 0, hasText)
            }
            searchResultTableView.reloadData()
        }
    }
    
}


