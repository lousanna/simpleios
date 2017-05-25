//
//  CustomTabBarController.swift
//  Blossom
//
//  Created by Lousanna Cai on 4/26/17.
//  Copyright © 2017 Lousanna Cai. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController, CustomTabBarDataSource, CustomTabBarDelegate, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isHidden = true
        self.selectedIndex = 0
        self.delegate = self
        
        let customTabBar = CustomTabBar(frame: self.tabBar.frame)
        customTabBar.datasource = self
        customTabBar.delegate = self
        customTabBar.alpha = 1.0
        customTabBar.setup()
        
        self.view.addSubview(customTabBar)
    }
    
    // MARK: - CustomTabBarDataSource
    
    func tabBarItemsInCustomTabBar(_ tabBarView: CustomTabBar) -> [UITabBarItem] {
        return tabBar.items!
    }
    
    // MARK: - CustomTabBarDelegate
    
    func didSelectViewController(_ tabBarView: CustomTabBar, atIndex index: Int) {
        self.selectedIndex = index
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTabAnimatedTransitioning()
    }
    
}

