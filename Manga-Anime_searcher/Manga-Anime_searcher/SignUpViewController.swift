//
//  SignUpViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPwField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
  
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmPwField.resignFirstResponder()
        emailField.resignFirstResponder()
        return true
    }
    

    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
//          // other fields can be set just like with PFObject
//          user["phone"] = "415-392-0202"
        let theuser = usernameField.text
        let thepw = passwordField.text
        let theemail = emailField.text
        let therepeatedPw = confirmPwField.text
        
        if (theuser!.isEmpty || thepw!.isEmpty || theemail!.isEmpty){
            let alert = UIAlertController(title: "Alert", message: "All fields are required to Sign up", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert,animated: true)
        }
        
        if (thepw != therepeatedPw) {
            let alert = UIAlertController(title: "Alert", message: "Passwords do not Match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert,animated: true)
        }
        
        user.signUpInBackground { (success, error)in
            if success {
                
                let alert = UIAlertController(title: "Alert", message: "you have registered", preferredStyle: .alert)
                self.present(alert,animated: true)
                let okAction = UIAlertAction(title: "OK", style: .default) {
                    (action: UIAlertAction!) in
                    self.dismiss(animated: true)
                }
            
                alert.addAction(okAction)
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                let alert = UIAlertController(title: "Alert", message: "Something went wrong: \(error?.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .default))
                self.present(alert,animated: true)
                print("Error: \(error?.localizedDescription)")
            }
            
        }
    }
    
    private func setup(){
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
    }
    
    func setupDismissKeyboardGesture(){
        //this code will dismiss the keyboard
        let dismisskeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(dismisskeyboardTap)

    }
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer){
        if recognizer.state == UIGestureRecognizer.State.ended{
            view.endEditing(true)
        }
    }
    
    func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(signinkeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(signinkeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

  

}
extension SignUpViewController {
    @objc func signinkeyboardWillShow(sender: NSNotification) {

        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextfield = UIResponder.currentFirst() as? UITextField else {
            return
        }
        
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextfield.frame, from: currentTextfield.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        print("print value for tefield: \(textFieldBottomY)")
        print("print value for keyboardtopy: \(keyboardTopY)")
        if textFieldBottomY > 520.0 {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newframey = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newframey
        }

    }
    @objc func signinkeyboardWillHide(sender: NSNotification){
        view.frame.origin.y = 0
    }
}
