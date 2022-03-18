//
//  MainTabBarController.swift
//  Netflix
//
//  Created by Sai Balaji on 14/03/22.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .white
        tabBar.tintColor = .white
        configureUI()
    }
    
    func configureUI(){
        let vc1 = createNavViewControllersForTabBar(vc: HomeViewController(), imageName: "house", tabTitle: "Home")

        
        let vc2 = createNavViewControllersForTabBar(vc: UpcomingViewController(), imageName: "play.circle", tabTitle: "Coming Soon")

        
      //  let vc3 = createNavViewControllersForTabBar(vc: DownloadsViewController(), imageName: "arrow.down.circle", tabTitle: "Downloads")

        
        let vc4 = createNavViewControllersForTabBar(vc: SearchViewController(), imageName: "magnifyingglass", tabTitle: "Search")
    
        viewControllers = [vc1,vc2,vc4]
    }
    
    func createNavViewControllersForTabBar(vc: UIViewController,imageName: String,tabTitle: String)->UINavigationController{
        
        let navvc = UINavigationController(rootViewController: vc)
        navvc.tabBarItem.image = UIImage(systemName: imageName)
        navvc.title = tabTitle
        return navvc
        
        
    }
}
