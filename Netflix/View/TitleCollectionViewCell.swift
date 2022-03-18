//
//  TitleCollectionViewCell.swift
//  Netflix
//
//  Created by Sai Balaji on 16/03/22.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    //MARK: - PROPERTIES
    static let IDENTIFIER = "TitleCollectionViewCell"
    
    private let PosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(PosterImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        PosterImage.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HELPER
    public func configure(posterURL: String?){
        guard let posterURL = posterURL else {return }
     
        let PURL = "https://image.tmdb.org/t/p/w500/\(posterURL)"
        guard let url = URL(string: PURL) else {return }
        PosterImage.sd_setImage(with: url, completed: nil)
    }
    
}
