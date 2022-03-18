//
//  HomeViewController.swift
//  Netflix
//
//  Created by Sai Balaji on 14/03/22.
//

import Foundation
import UIKit
import SDWebImage

class HomeViewController: UIViewController{
    //MARK: - PROPERTIES
    
    
    var TrendingMovieBanner: CustomHeaderView!
    var sectionTitles = ["Trending Movies","Popular","Trending TV","Upcoming Movies","Top Rated"]
    var HomeFeedTableView: UITableView = {
        let tableView = UITableView(frame: .zero,style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.IDENTIFIER)
        return tableView
    }()
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(HomeFeedTableView)
        HomeFeedTableView.delegate = self
        HomeFeedTableView.dataSource = self
        TrendingMovieBanner = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 520))
        TrendingMovieBanner.delegate = self
        HomeFeedTableView.tableHeaderView = TrendingMovieBanner
        configureUI()
        //getRandomTrendingMovie()
        //CollectionViewTableViewCell().delegate = self
        //getTrendingMovies()
        //getTrendingTVS()
        //getUpComingMovies()
        
        //navigationController?.pushViewController(MoviePreviewViewController(), animated: true)
       
    }
    
    //MARK: - HELPERS
    func configureUI(){
        HomeFeedTableView.frame = view.frame
       
        var logoimage = UIImage(named: "nlogo")
        logoimage = logoimage?.withRenderingMode(.alwaysOriginal)
   
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoimage, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName:"person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
            
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    

    
   /* func getTrendingMovies(){
        APICaller.sharedObj.getTrendingMovies { Result, error in
            if let err = error{
                print(err.localizedDescription)
            }
            if let r = Result{
                print(r)
                
            }
            
        }
    }
    
    func getTrendingTVS(){
        APICaller.sharedObj.getTrendingTV { result, error in
            print(result?.count)
        }
    }
    
    func getUpComingMovies(){
        APICaller.sharedObj.getUpComingMovies { results, error in
            if let r = results{
                print("COUNT\(r.count)")
            }
        }
    }*/

}

//MARK: - TABLE VIEW DELEGATE METHODS

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
  
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.IDENTIFIER, for: indexPath) as? CollectionViewTableViewCell{
            cell.delegate = self
            if indexPath.section == 0{
                APICaller.sharedObj.getTrendingMovies{ titles, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    if let data = titles{
                        cell.configure(with: data)
                    }
                    
                }
            }
            else if indexPath.section == 1{
                APICaller.sharedObj.getPopularMovies { titles, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    if let data = titles{
                        cell.configure(with: data)
                    }
                }
            }
            else if indexPath.section == 2{
                APICaller.sharedObj.getTrendingTV { titles, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    if let data = titles{
                        cell.configure(with: data)
                    }
                }
            }
            
            else if indexPath.section == 3{
                APICaller.sharedObj.getUpComingMovies { titles, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    if let data = titles{
                        cell.configure(with: data)
                    }

                }
            }
            else if indexPath.section == 4{
                APICaller.sharedObj.getTopRated { titles, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    if let data = titles{
                        cell.configure(with: data)
                    }
                }
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            return cell
            }
          return UITableViewCell()
        }
      
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return }
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        //header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}

extension HomeViewController: CollectionViewCellDelegate{
    func sentVideoID(vid: String, description: String?) {
        guard let description = description else {
            return
        }

        DispatchQueue.main.async {
            let mvc = MoviePreviewViewController()
            mvc.VIDEO_ID = vid
            mvc.OVER_VIEW = description
            
            self.navigationController?.pushViewController(mvc, animated: true)
        }
    }
    
   /* func sentVideoID(vid: String) {
        print("VIDEO\(vid)")
        DispatchQueue.main.async {
            //self.delegate?.sendVideoID(vid: vid)
            let mvc = MoviePreviewViewController()
            mvc.VIDEO_ID = vid
            self.navigationController?.pushViewController(mvc, animated: true)
            //self.present(MoviePreviewViewController(), animated: true, completion: nil)
        }
        
    }*/
    
    
}

extension HomeViewController: GetRandomMovieTrailerIDDelegate{
    func sendRandomMovieTrailerID(tid: String?, description: String?) {
        DispatchQueue.main.async {
            let mvc = MoviePreviewViewController()
            mvc.VIDEO_ID = tid!
            mvc.OVER_VIEW = description!
            self.navigationController?.pushViewController(mvc, animated: true)
        }
    }
}

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
        
    }
}

    
   

