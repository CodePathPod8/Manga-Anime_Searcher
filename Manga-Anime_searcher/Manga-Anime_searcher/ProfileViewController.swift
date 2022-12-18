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
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    
    let user = PFUser.current()!
    
    var profiles = [PFObject]()
    private struct Constants {
        static let borderWidth: CGFloat = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        
        // Do any additional setup after loading the view.
        title = "My Profile"
        profilepicImage.roundedpictures()
        configureTextView()
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
            profilepicImage.image = UIImage(named: "profilepicture-re")
        }
        
        //showing the username for the logged user
        usernameLabel.text = "@" + user.username!
        
    

       
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
    
    
    private func configureTextView() {
        bioTextView.layer.borderColor = UIColor.blue.cgColor
        bioTextView.layer.borderWidth = Constants.borderWidth
    }

   
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

extension UIImageView {
    func roundedpictures() {
        //make a image rounded
        self.layer.cornerRadius = self.frame.size.width/2
        clipsToBounds = true
        self.layer.borderWidth = 4.0
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func getShows() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 4.0
    }
}

extension ProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("editing started in address text view")
        bioTextView.layer.borderColor = UIColor.green.cgColor
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        bioTextView.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textViewDidChange(_ textView: UITextView,shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return false
    }
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        print("shouldChangeTextIn replacement text \(text)")
        
        return true
    }
}

extension ProfileViewController {
    @objc func signinkeyboardWillShow(sender: NSNotification) {

        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextfield = UIResponder.currentFirst() as? UITextField else {
            
            return
        }
        print(" this is the user info \(userInfo)")
        
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
        print("this gets call?")
        view.frame.origin.y = 0
    }
}
