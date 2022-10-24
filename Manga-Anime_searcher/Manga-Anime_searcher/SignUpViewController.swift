//
//  SignUpViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPwField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert,animated: true)
                self.dismiss(animated: true)
//                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                let alert = UIAlertController(title: "Alert", message: "Something went wrong: \(error?.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .default))
                self.present(alert,animated: true)
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
