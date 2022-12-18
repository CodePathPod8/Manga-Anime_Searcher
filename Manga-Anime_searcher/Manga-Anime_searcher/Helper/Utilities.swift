//
//  Utilities.swift
//  sastreilor
//
//  Created by Yunior Sanchez on 12/9/22.
//

import Foundation
import UIKit

class Utilities {
    static func styleTexField(_ textfield:UITextField) {
        //Create the botton line
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x:0,y:textfield.frame.height - 2,width: textfield.frame.width,height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1 ).cgColor
        
        //remove border on text field
        textfield.borderStyle = .none
        
        //add the line to the text field
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleHollowButton(_ button:UIButton){
        //hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailREgex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailREgex)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
}
extension UIResponder {
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    @objc private func _trap(){
        Static.responder = self
    }
}
