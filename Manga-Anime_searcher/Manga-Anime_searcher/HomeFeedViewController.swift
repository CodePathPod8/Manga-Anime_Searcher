//
//  HomeFeedViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func myAlert(title: String,message: String, handlerOK: ((UIAlertAction) -> Void)? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Logout", style: .default, handler: handlerOK)
//        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: handlerOK)
        alert.addAction(action)
//        alert.addAction(action2)
        DispatchQueue.main.async {
            self.present(alert,animated: true)
            alert.view.superview?.isUserInteractionEnabled = true
//            alert.view?.superview?.addGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside))
        }
        
    }
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
        myAlert(title: "Alert", message: "are you sure you want to log out?",handlerOK: {Action in
            
            PFUser.logOut()
            print("loggedout")
            let main = UIStoryboard(name: "Main",bundle: nil)
            let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,let delegate = windowScene.delegate as? SceneDelegate else {return}
            
            delegate.window?.rootViewController = loginViewController})
        
        
    }
    
}
