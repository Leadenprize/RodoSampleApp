//
//  ViewController.swift
//  RodoSampleApp
//
//  Created by Daniel Perez on 1/25/23.
//

import UIKit



class ContentViewController: UITabBarController, UITabBarControllerDelegate, HomeViewControllerDelegate{

    
    var tabOne:UINavigationController!
    // TODO: Implement tabTwo throught tabFive
    lazy var tabTwo:UIViewController = UIViewController()
    lazy var tabThree:UIViewController = UIViewController()
    lazy var tabFour:UIViewController = UIViewController()
    lazy var tabFive:UIViewController = UIViewController()
    lazy var homeView:HomeViewController = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
  
        setupUI()
        updateUI()
        styleUI()
     
        
    }
    
    func setupUI(){
        // TO Set a custom sized tab bar, a unique class is needed, see UIExtensions
        //setValue(CustomSizedTabBar(frame: tabBar.frame), forKey: "tabBar")
        //self.tabBar.sizeThatFits( CGSizeMake(50, 200))
        
        tabOne = UINavigationController(rootViewController:homeView)
        
        tabOne.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabOne"), selectedImage: UIImage(named: "tabOneSelected"))
        tabTwo.tabBarItem =  UITabBarItem(title: "", image: UIImage(named: "tabTwo"), selectedImage: UIImage(named: "tabTwo"))
        tabThree.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabThree"), selectedImage: UIImage(named: "tabThree"))
        tabFour.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabFour"), selectedImage: UIImage(named: "tabFive"))
        tabFive.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tabFive"), selectedImage: UIImage(named: "tabFive"))
        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour, tabFive ]
        homeView.delegate = self
    }
    
    func updateUI(){
        // IS THIS RIGHT? IT SEEMS ODD
        if( homeView.navigationController?.navigationBar.isHidden == false ){
            tabThree.tabBarItem.badgeValue = nil
            tabFour.tabBarItem.badgeValue = nil
            tabOne.tabBarItem.selectedImage = UIImage(named:"tabOne")
      //      self.setNeedsStatusBarAppearanceUpdate()
       }
        else{
            tabThree.tabBarItem.badgeValue = ""
            tabFour.tabBarItem.badgeValue = ""
            tabOne.tabBarItem.selectedImage = UIImage(named:"tabOneSelected")
       
        }
    }
   
    func styleUI(){
        //  TabBar Style
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.itemPositioning = UITabBar.ItemPositioning.centered
        self.tabBar.tintColor = UIColor.black
        self.tabBar.unselectedItemTintColor = UIColor.black

        tabOne.tabBarItem.setBadgeTextAttributes([NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter", size: 6)!], for: .normal)
        tabOne.tabBarItem.setBadgeTextAttributes([NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter", size: 6)!], for: .selected)
        tabThree.tabBarItem.badgeColor = rodoSampleAppUIStyleSettings.foregroundColor
        tabFour.tabBarItem.badgeColor = rodoSampleAppUIStyleSettings.foregroundColor
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        
        
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Deactivate all tabs except for HomeViewController
        if( (viewController is HomeViewController ) == false ){
            self.selectedIndex = 0;
            homeView.navigationController?.isNavigationBarHidden = true
            updateUI()
            
        }
    }
    
    // HomeViewControllerDelegate Methods
    func homeViewControllerNavigationNeeded(){
        homeView.navigationController?.navigationBar.isHidden = false
        let vehicleTypeViewController = VehicleTypeViewController()
        vehicleTypeViewController.navigationController?.navigationBar.isHidden = false
        tabOne.pushViewController( vehicleTypeViewController, animated: true)
        updateUI()
    }
    
    func homeViewControllerUpdateNeeded(){
        
        updateUI()
    }
    
    

}

