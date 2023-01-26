//
//  UIExtensions.swift
//  RodoSampleApp
//
//  Created by Daniel Perez on 1/25/23.
//

import Foundation
import UIKit

// Helper methods to make it easier on the rest

// *** NEEDED FOR iOS 11 Support
// Convenience Wrapper around UIControls so you can addAction easier
// Note: Neccessary to support ios 11 as addAction only available for ios 14 and greater
//  @objc NSObject needed to put closure in place
// UUID() used to avoid conflict associatedObject

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        @objc class ClosureWrapper: NSObject {
            let closure:()->()
            init(_ closure: @escaping()->()) { self.closure = closure }
            @objc func invoke() { closure() }
        }
        let sleeve = ClosureWrapper(closure)
        addTarget(sleeve, action: #selector(ClosureWrapper.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

// Convenience extension for adding padding to TextField
// UITextField.addPadding( .left(20) )
extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true


        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

// IN order to resize TabBar we must create a custom TabBar class and override the sizeThatFits
class CustomSizedTabBar: UITabBar {
 
    override func sizeThatFits(_ size: CGSize) -> CGSize {
          let size = super.sizeThatFits(size)
        //  size.height = 57
        
          return size
     }
}


