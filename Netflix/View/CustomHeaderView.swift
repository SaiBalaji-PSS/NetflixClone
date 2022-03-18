//
//  CustomHeaderView.swift
//  Netflix
//
//  Created by Sai Balaji on 15/03/22.
//

import Foundation
import UIKit
import SDWebImage

protocol GetRandomMovieTrailerIDDelegate{
    func sendRandomMovieTrailerID(tid: String?,description: String?)
}

class CustomHeaderView: UIView{
    
    var delegate: GetRandomMovieTrailerIDDelegate?
    var RandomMovie: Title?
    
    public let BannerImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named:"poster")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
   /* private let DownloadButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Download", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 3
        return btn
    }()*/
    
    private let PlayButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Play", for: .normal)
        btn.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 3
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(BannerImageView)
        addGradient()
        addSubview(PlayButton)
      //  addSubview(DownloadButton)
        configureUI()
        getRandomTrendingMovie()
    }
    
    override func layoutSubviews() {
        BannerImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    
    private func configureUI(){
        PlayButton.translatesAutoresizingMaskIntoConstraints = false
        PlayButton.leftAnchor.constraint(equalTo: leftAnchor,constant: 25).isActive = true
        PlayButton.rightAnchor.constraint(equalTo: rightAnchor,constant: -25).isActive = true
        PlayButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -100).isActive = true
        PlayButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        PlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
       /* DownloadButton.translatesAutoresizingMaskIntoConstraints = false
        DownloadButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        DownloadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        DownloadButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -100).isActive = true
        DownloadButton.rightAnchor.constraint(equalTo: rightAnchor,constant: -25).isActive = true*/
    }
    
    
    func getRandomTrendingMovie(){
        APICaller.sharedObj.getTrendingMovies { Movies, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let Movies = Movies {
                DispatchQueue.main.async {
                    self.RandomMovie = Movies.randomElement()
                   
                    guard let randomMoviePosterURL = self.RandomMovie?.poster_path else{return}
                    self.BannerImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(randomMoviePosterURL)"), completed: nil)
                }
               
                
            }
        }
    }
    
    @objc func playButtonPressed(){
        print("PLAY")
        guard let query = RandomMovie?.original_title ?? RandomMovie?.original_name else {return }
        print("QUERY IS \(query)")
        
        APICaller.sharedObj.getMoiveFromYoutube(Query: query) { VideoElement, error in
            print("INSIDE THE FUNC")
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
           
            if let VideoElement = VideoElement {
                print("AFTER")
                self.delegate?.sendRandomMovieTrailerID(tid: VideoElement.first?.id.videoId,description: self.RandomMovie?.overview)
            }
            //print(VideoElement!)
          

        }
        
        
    }
}
