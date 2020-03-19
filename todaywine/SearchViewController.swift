//
//  SearchViewController.swift
//  todaywine
//
//  Created by jimmy on 2020/02/20.
//  Copyright © 2020 jimmy. All rights reserved.
//

import UIKit


class SearchViewController: UIViewControllerBase {
    
    var wines: [WineV2] = []
    
    var filteredWineList: [WineV2] = []
    var isFiltered = false
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        
        searchVC.searchResultsUpdater = self
        searchVC.obscuresBackgroundDuringPresentation = false
        searchVC.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.searchController = searchVC
        self.navigationItem.hidesSearchBarWhenScrolling = false
        

        self.navigationController?.navigationBar.topItem?.titleView = searchVC.searchBar
//        self.navigationController?.navigationBar.topItem?.titleView = searchBar.
//        self.navigationController?.navigationBar
        definesPresentationContext = false
        
        searchResultTableView.register(UINib(nibName: "WineCell", bundle: nil), forCellReuseIdentifier: "wineCell")
        
        let jsonDecoder = JSONDecoder()
        guard let wineData : NSDataAsset = NSDataAsset(name: "wineV2") else {
            return
        }
        do {
            self.wines = try jsonDecoder.decode([WineV2].self, from: wineData.data)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        switch indexPath.row {
//        case 0: self.performSegue(withIdentifier: "photoObjectDetection", sender: nil)
//        case 1: self.performSegue(withIdentifier: "realTimeObjectDetection", sender: nil)
//        case 2: self.performSegue(withIdentifier: "facialAnalysis", sender: nil)
//        default:
//            return
//        }
        
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
        
        present(vc, animated: true, completion: nil)
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


