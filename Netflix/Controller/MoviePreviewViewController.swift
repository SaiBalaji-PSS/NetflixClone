//
//  MoviePreviewViewController.swift
//  Netflix
//
//  Created by Sai Balaji on 17/03/22.
//

import UIKit
import WebKit

class MoviePreviewViewController: UIViewController {

    //MARK: - PROPERTY
    private let webView: WKWebView = WKWebView()
    
    public var VIDEO_ID: String  = ""
    public var OVER_VIEW: String = ""
    
    
    /*private let DownloadButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Download", for: .normal)
        btn.backgroundColor = .systemPink
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 5
        btn.tintColor = .white
        return btn
    }()*/
    
    private let OverviewLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 18)
        //lbl.text = "Here goes movie overview sfnslffjnlfkjsjsfksdlfkj"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(webView)
        view.addSubview(OverviewLabel)
       // view.addSubview(DownloadButton)
        configureUI()
        webView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(VIDEO_ID)")!))
       
        view.backgroundColor = .systemBackground
        
       
    }
    

    
    //MARK: - HELPERS
    func configureUI(){
        
        OverviewLabel.text = OVER_VIEW
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        webView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        webView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100).isActive = true
        
      /*  DownloadButton.translatesAutoresizingMaskIntoConstraints = false
        DownloadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -120).isActive = true
        DownloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        DownloadButton.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        DownloadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true*/
        
        OverviewLabel.translatesAutoresizingMaskIntoConstraints = false
        OverviewLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        OverviewLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        OverviewLabel.topAnchor.constraint(equalTo: webView.bottomAnchor,constant: 20).isActive = true
    }
    

}

