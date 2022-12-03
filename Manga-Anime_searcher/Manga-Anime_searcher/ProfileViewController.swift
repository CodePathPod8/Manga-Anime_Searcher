//
//  ProfileViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse
import AlamofireImage

protocol ImageUploading {
    func uploadImage(image: UIImage)
}
class ProfileViewController: UIViewController,ImageUploading {
    func uploadImage(image: UIImage) {
            profilepicImage.image = image
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let viewController = segue.destination as? ProfileCamViewController{
                viewController.imageUploader = self
                
            }
        }
    
    @IBOutlet weak var profilepicImage: UIImageView!
    
    @IBOutlet weak var BioTextView: UILabel!
    
    @IBOutlet weak var bioContentTextView: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    let user = PFUser.current()!
    
    var profiles = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        bioContentTextView.text = "Tell everyone about you"
        bioContentTextView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        
//
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if user["profileimage"] != nil {
            let imageFile = user["profileimage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profilepicImage.af.setImage(withURL: url)
        } else {
            profilepicImage.image = UIImage(named: "profile_tab")
        }
        
        //showing the username for the logged user
        usernameLabel.text = "@ " + user.username!
        
        
        

       
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
        //creating alert to confirm log out
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to log out?", preferredStyle: .alert)
        
        present(alert,animated: true)
        
        //creating logout confirmation
        let confimAction = UIAlertAction(title: "Confirm", style: .default) {
            (action: UIAlertAction!) in
            PFUser.logOut()
            print("loggedout")
            let main = UIStoryboard(name: "Main",bundle: nil)
            let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
            
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,let delegate = windowScene.delegate as? SceneDelegate else {return}
            
            delegate.window?.rootViewController = loginViewController
        }
        //creating action to cancel and stay logged in
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        //adding both action to the alert pop up
        alert.addAction(confimAction)
        alert.addAction(cancelAction)
    }
    
}
