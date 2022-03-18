//
//  UpcomingViewController.swift
//  Netflix
//
//  Created by Sai Balaji on 14/03/22.
//

import UIKit

class UpcomingViewController: UIViewController {

    //MARK: - PROPERTIES
    private var UpComingMovies = [Title]()
    private var UpcomingMoviesTableView: UITableView = {
        let tv = UITableView(frame: .zero,style: .grouped)
        tv.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.IDENTIFIER)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(UpcomingMoviesTableView)
        configureUI()
        UpcomingMoviesTableView.delegate = self
        UpcomingMoviesTableView.dataSource = self
        
        
        APICaller.sharedObj.getUpComingMovies { titles, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let titles = titles else {
                return
            }

            
            
            DispatchQueue.main.async {
                self.UpComingMovies = titles
                self.UpcomingMoviesTableView.reloadData()
            }
            
        }
    }
    

    
        //MARK: - HELPERS
    func configureUI(){
        UpcomingMoviesTableView.translatesAutoresizingMaskIntoConstraints = false
        UpcomingMoviesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        UpcomingMoviesTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        UpcomingMoviesTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        UpcomingMoviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
 
    

}

extension UpcomingViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UpComingMovies.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.IDENTIFIER, for: indexPath) as? UpcomingTableViewCell{
            cell.upDateCell(imageURL: UpComingMovies[indexPath.row].poster_path,movieName: UpComingMovies[indexPath.row].original_title)
           return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        guard let query = UpComingMovies[indexPath.row].original_title ?? UpComingMovies[indexPath.row].original_name else {return}
        APICaller.sharedObj.getMoiveFromYoutube(Query: query) { videodata, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let videodata = videodata {
              
                DispatchQueue.main.async {
                    let mvc = MoviePreviewViewController()
                
                    mvc.VIDEO_ID = videodata.first!.id.videoId
                    mvc.OVER_VIEW = self.UpComingMovies[indexPath.row].overview!
                    print("SSSSS\(mvc.VIDEO_ID)")
                    self.navigationController?.pushViewController(mvc, animated: true)
                }
            }
                
        }
       
    }
}
