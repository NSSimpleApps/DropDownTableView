//
//  TestViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 06.03.16.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

import UIKit


extension UIAlertController {
    
    convenience init(title: String, placeholders: [String], completion: (([String?]) -> Void)?) {
        
        self.init(title: title, message: nil, preferredStyle: .alert)
        
        for (index, placeholder) in placeholders.enumerated() {
            
            self.addTextField(configurationHandler: { (textField: UITextField) -> Void in
                
                textField.placeholder = placeholder
                
                if index == 0 {
                    
                    textField.delegate = self
                }
            })
        }
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (alertAction) -> Void in
            
            let texts = self.textFields?.map({ (textField: UITextField) -> String? in
                
                return textField.text
            })
            
            completion?(texts!)
        }
        OKAction.isEnabled = false
        
        self.addAction(OKAction)
        self.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
}

extension UIAlertController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            
            self.actions.first?.isEnabled = textField.text!.characters.count > 1
            
        } else {
            
            self.actions.first?.isEnabled = textField.text!.characters.count > 0
        }
        
        return true
    }
}
