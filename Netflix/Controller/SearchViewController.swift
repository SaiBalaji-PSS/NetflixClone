//
//  SearchViewController.swift
//  Netflix
//
//  Created by Sai Balaji on 14/03/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
   
    

    //MARK: - PROPERTIES
    private let DiscoverTableView: UITableView = {
        let tv = UITableView()
        tv.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.IDENTIFIER)
        return tv
    }()
    
    private let SearchController: UISearchController = {
        let sc = UISearchController(searchResultsController: SearchResultViewController())
        sc.searchBar.placeholder = "Search for a Movie or a Tv Show"
        sc.searchBar.searchBarStyle = .minimal
        return sc
    }()
    
    private var Movies = [Title]()
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        view.addSubview(DiscoverTableView)
        configureUI()
        
        self.DiscoverTableView.delegate = self
        self.DiscoverTableView.dataSource = self
        
        SearchController.searchResultsUpdater = self
        
        
        APICaller.sharedObj.getDiscoverMovie { title, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = title{
                self.Movies = data
                DispatchQueue.main.async {
                    self.DiscoverTableView.reloadData()
                }
            }
            
        }
 
    }
    
    //MARK: - HELPERS
    func configureUI(){
        
        navigationItem.searchController =  SearchController
        
        DiscoverTableView.translatesAutoresizingMaskIntoConstraints = false
        DiscoverTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        DiscoverTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        DiscoverTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        DiscoverTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar
        
        guard let query = searchController.searchBar.text, !query.isEmpty  else {return }
        
       if  let resultcontroller = searchController.searchResultsController as? SearchResultViewController {
           APICaller.sharedObj.search(Query: query.trimmingCharacters(in: .whitespaces)) { title, error in
               if let error = error {
                   print(error.localizedDescription)
                   return
               }
               if let data = title{
                   resultcontroller.Movies = data
                   DispatchQueue.main.async {
                       resultcontroller.SearchResultCollectionView.reloadData()
                   }
          
               }
           }
       
        }
        
     
    }

 

}

//MARK: - TABLE VIEW DELEGATE METHOD
extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.IDENTIFIER, for: indexPath) as? UpcomingTableViewCell else{
            return UITableViewCell()
        }
        
        cell.upDateCell(imageURL: self.Movies[indexPath.row].poster_path, movieName: self.Movies[indexPath.row].original_title)
        return cell
    }
}
