//
//  LoginViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
