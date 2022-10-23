//
//  ProfileViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profilepicImage: UIImageView!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var profiles = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        
        let query = PFQuery(className:"ProfilePic")
        
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground {(profiles,error)in
            if profiles != nil {
                self.profiles = profiles!
//                self.tableView.reloadData()
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
    @IBAction func onLogoutBtn(_ sender: Any) {
        PFUser.logOut()
        print("loggedout")
        let main = UIStoryboard(name: "Main",bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
    }
    
}
