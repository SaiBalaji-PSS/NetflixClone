//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Sai Balaji on 15/03/22.
//

import Foundation
import UIKit


protocol CollectionViewCellDelegate{
    func sentVideoID(vid: String,description:String?)
}


class CollectionViewTableViewCell: UITableViewCell{
    //MARK: - PROPERTIES
    static var IDENTIFIER = "CollectionViewTableViewCell"
    var delegate: CollectionViewCellDelegate?
    private var Movies = [Title]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 144, height: 200)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = true
        
        cv.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.IDENTIFIER)
        return cv
    }()
    
 
    
    
    //MARK: - CONSTRUCTORS
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: CollectionViewTableViewCell.IDENTIFIER)
        //contentView.backgroundColor = .systemPink
        
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        //configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - HELPERS
    func configureUI(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        collectionView.frame = contentView.bounds
    }
    
    func configure(with titles:[Title]){
        self.Movies = titles
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    
}

//MARK: - COLLECTIONVIEW DELEGATE METHODS
extension CollectionViewTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.IDENTIFIER, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell() }
        
        
        cell.configure(posterURL: self.Movies[indexPath.row].poster_path)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let SearchQuery = Movies[indexPath.row].original_title ?? Movies[indexPath.row].original_name else {return }
        
        print("INSIDE")
        
        APICaller.sharedObj.getMoiveFromYoutube(Query: SearchQuery) { videoelements, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = videoelements{
              
                
                self.delegate?.sentVideoID(vid:data.first!.id.videoId,description: self.Movies[indexPath.row].overview)
                
            }
            
        }

        
    }
    
}

extension UITableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
    
}
