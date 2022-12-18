//
//  LoginViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        setup()
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
 
    //making the return from keyboard funtion to make the keyboard disapear
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return true
    }
    
   
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground:username, password:password) {
          (user, error) in
          if user != nil {
            // Do stuff after successful login.
              self.performSegue(withIdentifier: "loginSegue", sender: nil)
              
          } else {
        
              
              if (username.isEmpty || password.isEmpty ){
                  let alert = UIAlertController(title: "Alert", message: "All fields are required to Sign up", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "OK", style: .default))
                  self.present(alert,animated: true)
              }
            // The login failed. Check error to see why.
              print("Error: \(error?.localizedDescription)")
              
          }
        }
    }
    
    
   

}
extension LoginViewController {
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
