//
//  VehicleTypeViewController.swift
//  RodoSampleApp
//
//  Created by Daniel Perez on 1/25/23.
//

import Foundation
import UIKit


struct VehicleTypeItem {
    var vehicleImageName:String
    var vehicleTitle:String
    var vehicleIsSelected:Bool
    init(_ arg1:String,_ arg2:String){
        vehicleImageName = arg1
        vehicleTitle = arg2
        vehicleIsSelected = false
    }
}

// This is the Vehicle Type Detail screen seen after HomeView

class VehicleTypeViewController: UIViewController {
    
    // Keep track of last vehicle Tapped
    public var vehicleSelectedIndex:Int = -1
    
    public var vehicleTypes:[VehicleTypeItem] = [
        VehicleTypeItem( "compact", "Compact" ),
        VehicleTypeItem( "convertible", "Convertible" ),
        VehicleTypeItem( "coupe", "Coupe" ),
        VehicleTypeItem( "hatchback", "Hatchback" ),
        VehicleTypeItem( "hybrid", "Hybrid/Electric" ),
        VehicleTypeItem( "midsize", "Midsize" ),
        VehicleTypeItem( "minivan", "Minivan" ),
        VehicleTypeItem( "sedan", "Sedan" ),
        VehicleTypeItem( "smallsuv", "Small SUV" ),
        VehicleTypeItem( "sports", "Sports" ),
        VehicleTypeItem( "suv", "SUV" ),
        VehicleTypeItem( "truck", "Truck" ),
        
        ]
    
    var vehicleTypeButtons:[UIButton] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        styleUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateUI()
        
    }
    
    private var BGView = UIView( frame:CGRectZero )
    
    func setupUI(){

        // Having issue where Status Bar doesn't show
        // so use maxNavBarHeight above to keep in memory safeAreas
         
        self.view.addSubview( BGView )
        BGView.translatesAutoresizingMaskIntoConstraints = false
        BGView.backgroundColor = rodoSampleAppUIStyleSettings.homeBackgroundColor
        BGView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        BGView.widthAnchor.constraint(equalTo:self.view.widthAnchor ).isActive = true
        self.navigationController?.navigationBar.isHidden = false
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0
            
        BGView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:topPadding+1).isActive = true
    
        BGView.bottomAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
                                    
        
        
        
        // Customize nav bar first
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Vehicle Type"
        
        self.navigationController!.navigationBar.backgroundColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: rodoSampleAppUIStyleSettings.fontStyle, size: 20.0)!,
            .foregroundColor: UIColor.black]
        self.navigationController!.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.black ]
        self.navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.topItem?.title = ""
        var vehicleTypeIndex:Int = 0
        var lastButton:UIButton?
        for vehicleType in vehicleTypes {
            let vehicleTypeLabel:UILabel = UILabel(frame: CGRectZero)
            vehicleTypeLabel.textColor = rodoSampleAppUIStyleSettings.vehicleTitleTextColor
            vehicleTypeLabel.translatesAutoresizingMaskIntoConstraints = false
            vehicleTypeLabel.textAlignment = .center
            vehicleTypeLabel.font = UIFont(name: rodoSampleAppUIStyleSettings.fontStyle, size: rodoSampleAppUIStyleSettings.vehicleTitleTextSize)
            
            
            let vehicleTypeButton:UIButton = UIButton(frame: CGRectZero)
            view.addSubview( vehicleTypeLabel)
            //( image: UIImage( named: "compact"))
            view.addSubview( vehicleTypeButton  )
            vehicleTypeButton.layer.borderColor = UIColor.blue.cgColor

            vehicleTypeButton.translatesAutoresizingMaskIntoConstraints = false
            vehicleTypeButton.widthAnchor.constraint(equalToConstant: 105).isActive = true
            vehicleTypeButton.heightAnchor.constraint(equalToConstant: 50.4).isActive = true
             let column:Int = vehicleTypeIndex < vehicleTypes.count/2 ? 1 : 2
            let spacerwidth:CGFloat = 105+(view.frame.width/375)*57
            let spacerheight:CGFloat = 32.6
            if( column == 1 ){
                vehicleTypeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -spacerwidth/2).isActive = true
            }
            else{
                vehicleTypeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: +spacerwidth/2).isActive = true
            }
            
            
            if( lastButton == nil ){
                vehicleTypeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 111+(view.frame.height-675)/2).isActive = true;
            }
            else{
                vehicleTypeButton.topAnchor.constraint(equalTo: lastButton!.bottomAnchor, constant: spacerheight).isActive = true;
            }
            // Start over at top of column 2
            lastButton = vehicleTypeButton
            
              vehicleTypeLabel.topAnchor.constraint( equalTo: vehicleTypeButton.bottomAnchor).isActive = true
              vehicleTypeLabel.centerXAnchor.constraint( equalTo: vehicleTypeButton.centerXAnchor ).isActive = true
              vehicleTypeLabel.widthAnchor.constraint(equalToConstant: 105).isActive = true
              vehicleTypeLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
            
          
            vehicleTypeButton.setImage( UIImage( named:vehicleType.vehicleImageName),for: .normal)
            vehicleTypeLabel.text = vehicleType.vehicleTitle

            vehicleTypeButtons.append( vehicleTypeButton )
            
            // need local scope so lets create vehicleNum instead of vehicleTypeIndex
            let vehicleNum:Int = vehicleTypeIndex
            vehicleTypeButtons[vehicleTypeIndex].addAction {
                self.vehicleSelectedIndex = vehicleNum
                self.updateUI()
            }
            vehicleTypeIndex += 1
            if( column == 1 && vehicleTypeIndex >= vehicleTypes.count/2){
                lastButton = nil
            }

        }
            
        
    }
   
  
    
    func updateUI(){
      
        for i in 0..<vehicleTypes.count {
            if( i == vehicleSelectedIndex ){
                
            }
            vehicleTypeButtons[i].layer.borderWidth = i == vehicleSelectedIndex ? 1 : 0
            
        }
        self.setNeedsStatusBarAppearanceUpdate()
        self.view.setNeedsLayout()
        
    }

    func styleUI(){
        
        view.backgroundColor = UIColor.white
        
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
    
    
    

