//
//  SearchResultViewController.swift
//  Netflix
//
//  Created by Sai Balaji on 17/03/22.
//

import UIKit

class SearchResultViewController: UIViewController {

    //MARK: - PROPERTIES
    public let SearchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        cv.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.IDENTIFIER)

        return cv
    }()
    
    public var Movies = [Title]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .white
       
        view.backgroundColor = .systemBackground
        view.addSubview(SearchResultCollectionView)
        SearchResultCollectionView.delegate = self
        SearchResultCollectionView.dataSource = self
        configureUI()

    }
    

    //HELPER
    func configureUI(){
        SearchResultCollectionView.translatesAutoresizingMaskIntoConstraints = false
        SearchResultCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        SearchResultCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        SearchResultCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        SearchResultCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
   
}

extension SearchResultViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.IDENTIFIER, for: indexPath) as? TitleCollectionViewCell else{return UICollectionViewCell()}
        cell.backgroundColor = .systemGreen
        cell.configure(posterURL: Movies[indexPath.row].poster_path)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let query = Movies[indexPath.row].original_title ?? Movies[indexPath.row].original_name else {return}
        APICaller.sharedObj.getMoiveFromYoutube(Query: query) { videodata, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let videodata = videodata {
              
                DispatchQueue.main.async {
                    let mvc = MoviePreviewViewController()
                
                    mvc.VIDEO_ID = videodata.first!.id.videoId
                    mvc.OVER_VIEW = self.Movies[indexPath.row].overview!
                    //print("SSSSS\(mvc.VIDEO_ID)")
                    self.present(mvc, animated: true, completion: nil)
                }
            }
                
        }
    }
}
