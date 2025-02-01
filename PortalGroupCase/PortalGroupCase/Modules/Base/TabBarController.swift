//
//  TabBarController.swift
//  PortalGroupCase
//
//  Created by Atilla Çıtırık on 13.01.2025.
//

import UIKit

extension TabBarController {
    enum Constants {
        //MARK: - RocketList
        static let rocketListStoryboardFileName = "RocketList"
        static let rocketListNavBar = "RocketListNavBar"
        static let rocketListVCTabbarImage = "house"
        static let rocketVCTitle = "Home"
        
        //MARK: - Basket
        static let basketStoryboardFileName = "Basket"
        static let basketNavBar = "BasketNavBar"
        static let basketVCTabbarImage = "basket"
        static let basketVCTitle = "Basket"
    }
}

class TabBarController: UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartBadge), name: .changedBasketCount, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .changedBasketCount, object: nil)
    }
    
    //MARK: - Setup
    private func setupTabBar() {
        
        let roketListVC = createTabBarItem(storyboardFileName: Constants.rocketListStoryboardFileName, navBarIdentifier: Constants.rocketListNavBar, tabBarImage: Constants.rocketListVCTabbarImage, tabBarTitle: Constants.rocketVCTitle, tag: 0)

        let basketVC = createTabBarItem(storyboardFileName: Constants.basketStoryboardFileName, navBarIdentifier: Constants.basketNavBar, tabBarImage: Constants.basketVCTabbarImage, tabBarTitle: Constants.basketVCTabbarImage, tag: 1)
        
        setViewControllers([roketListVC, basketVC], animated: false)
        
    }
    
    //MARK: - Func
    private func createTabBarItem(storyboardFileName: String, navBarIdentifier: String, tabBarImage: String, tabBarTitle: String, tag: Int) -> UIViewController {
        
        let storyboardFileName = UIStoryboard(name: storyboardFileName, bundle: nil)
        let instantiatedVC = storyboardFileName.instantiateViewController(withIdentifier: navBarIdentifier)
        
        instantiatedVC.tabBarItem.image = UIImage(systemName: tabBarImage)
        instantiatedVC.title = tabBarTitle
        instantiatedVC.tabBarItem.tag = tag
        return instantiatedVC
    }
    
    @objc private func updateCartBadge(_ notification: Notification) {
        let basketQuantity = CoreDataManager.shared.fetchTotalBasketQuantity()
        if let cartTab = self.tabBar.items?[1] {
            cartTab.badgeValue = basketQuantity > 0 ? "\(basketQuantity)" : nil
        }
    }
    
}


