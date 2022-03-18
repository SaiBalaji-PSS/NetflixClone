//
//  UpcomingTableViewCell.swift
//  Netflix
//
//  Created by Sai Balaji on 16/03/22.
//

import UIKit
import SDWebImage

class UpcomingTableViewCell: UITableViewCell {

    //MARK: - PROPERTIES
    static let IDENTIFIER = "UpcomingMovieCell"
    
    private var PosterImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        //iv.backgroundColor = .purple
        return iv
    }()
    
    private var MovieNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        //lbl.text = "MOVIE_NAME_HEREdfgfdfgdfgdfgdfgdgdfgdfgdfgdggdg"
        lbl.numberOfLines = 0
        lbl.textColor = .white
        return lbl
    }()
    
    private var PlayButton: UIButton = {
        let btn = UIButton(type: .system)
        let playlogo = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
        
        btn.setImage(playlogo, for: .normal)
        //btn.backgroundColor = .purple
        btn.tintColor = .white
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(PosterImageView)
        addSubview(MovieNameLabel)
        addSubview(PlayButton)
        configureUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HELPERS
    func configureUI(){
        PosterImageView.translatesAutoresizingMaskIntoConstraints = false
        PosterImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        PosterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        PosterImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        PosterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        MovieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        MovieNameLabel.leftAnchor.constraint(equalTo: PosterImageView.rightAnchor,constant: 25).isActive = true
        MovieNameLabel.rightAnchor.constraint(equalTo: PlayButton.leftAnchor).isActive = true
        MovieNameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 80).isActive = true
        
        PlayButton.translatesAutoresizingMaskIntoConstraints = false
        PlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        PlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        PlayButton.topAnchor.constraint(equalTo: topAnchor, constant: 70).isActive = true
        PlayButton.leftAnchor.constraint(equalTo: MovieNameLabel.rightAnchor,constant: 20).isActive = true
      //  PlayButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -100).isActive = true
        PlayButton.rightAnchor.constraint(equalTo: rightAnchor,constant: -5).isActive = true
        
    }
    
    func upDateCell(imageURL: String?,movieName: String?){
        guard let imageURL = imageURL else {
            return
        }
        let PURL = "https://image.tmdb.org/t/p/w500/\(imageURL)"
        guard let url = URL(string: PURL) else {return }
        PosterImageView.sd_setImage(with: url, completed: nil)
        
        guard let movieName = movieName else {
            return
        }
        
        self.MovieNameLabel.text = movieName
    }
    

}
