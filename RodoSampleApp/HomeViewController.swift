//
//  HomeViewController.swift
//  RodoSampleApp
//
//  Created by Daniel Perez on 1/25/23.
//

import Foundation
import UIKit

protocol HomeViewControllerDelegate {
    func homeViewControllerNavigationNeeded()->()
    func homeViewControllerUpdateNeeded()->()
}



class HomeViewController: UIViewController, UITextFieldDelegate {
    
    var delegate : HomeViewControllerDelegate?
    
    var homeViewControllerViewModel : HomeViewControllerViewModel = HomeViewControllerViewModel()
    
   
    
    // UIView elements
    var logo: UIImageView!
    var searchTextField: UITextField!
    var button1: UIButton!
    var button2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        styleUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
   
  
    func setupUI(){
        
        
        // Create the elements
        logo = UIImageView(image: UIImage(named: "rodoLogo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        searchTextField = UITextField(frame: CGRectZero )
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = UIFont(name: rodoSampleAppUIStyleSettings.fontStyle, size: rodoSampleAppUIStyleSettings.normalfontSize )
        searchTextField.autocorrectionType = UITextAutocorrectionType.no
        searchTextField.keyboardType = UIKeyboardType.default
        searchTextField.returnKeyType = UIReturnKeyType.done
        searchTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        searchTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        searchTextField.layer.cornerRadius = 25
        searchTextField.backgroundColor = UIColor.white
        
        searchTextField.addPadding( .left(20))
        searchTextField.delegate = self
        
        button1   =  makeStandardAppButton()
        button2   = makeStandardAppButton()
        
        // ADD ELEMENTS TO VIEW
        view.addSubview( logo )
        view.addSubview(searchTextField)
        view.addSubview( button1 )
        view.addSubview( button2 )
      
        
        // SET ANCHORS FOR AUTOLAYOUT ( Height better layout than bottomAnchor )
        searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 270).isActive = true;
        //searchTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -351.14).isActive = true;
        searchTextField.widthAnchor.constraint(equalToConstant: 330).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true

    
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logo.bottomAnchor.constraint( equalTo: searchTextField.topAnchor, constant: -25 ).isActive = true
        logo.widthAnchor.constraint( equalToConstant: 185 ).isActive = true
        logo.heightAnchor.constraint( equalToConstant: 75).isActive = true
    
        button1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button1.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 80).isActive = true;
        button1.widthAnchor.constraint(equalToConstant: 330).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 48).isActive = true
       
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 146).isActive = true;
        button2.widthAnchor.constraint(equalToConstant: 330).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        // SET DEFAULT ACTIONS
        searchTextField.placeholder = "SEARCH MAKE AND MODEL"
        button1.setTitle("SEARCH BY VEHICLE TYPE", for: .normal)
        button2.setTitle("SEE DEAL OF THE DAY", for: .normal)
        
        
        button1.addAction(for: .touchUpInside) {
            self.delegate?.homeViewControllerNavigationNeeded()
        }
        
        button2.addAction(for: .touchUpInside) {
            self.homeViewControllerViewModel.searchMakeAndModel = self.searchTextField?.text ?? ""
            self.homeViewControllerViewModel.setupInventory()
            self.homeViewControllerViewModel.searchInventory()
        }
    }
    
    
    
    func updateUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.delegate?.homeViewControllerUpdateNeeded()
    }

    func styleUI(){
        
        view.backgroundColor = rodoSampleAppUIStyleSettings.homeBackgroundColor
        
      
    }
    
    // UITextField Delegates
        func textFieldDidBeginEditing(_ textField: UITextField) {
            
        }
        // TODO TODO
        // Maybe do some preliminary checking here!
        func textFieldDidEndEditing(_ textField: UITextField) {
        }
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            return true;
        }
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            return true;
        }
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true;
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return true;
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder();
            return true;
        }
    
    
    
}
