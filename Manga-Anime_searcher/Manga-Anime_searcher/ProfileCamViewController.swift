//
//  ProfileCamViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/23/22.
//

import UIKit
import Parse
import AlamofireImage

class ProfileCamViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onUpdateProfilePicBtn(_ sender: Any) {
        let profile = PFObject(className: "ProfilePic")
        
        profile["author"] = PFUser.current()!
        
        let imageData = profileImageView.image!.pngData()
        let file = PFFileObject(name:"image.png",data: imageData!)
        
        profile["image"] = file
        
        profile.saveInBackground{
            (success,error) in
            if success {
                self.dismiss(animated: true)
                print("saved!")
            } else {
                print("error!")
            }
        }
    }
    
    @IBAction func onProfileCamBtn(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300,height: 300)
        let scaledImage = image.af.imageAspectScaled(toFit: size)
        
        profileImageView.image = scaledImage
        
        dismiss(animated: true)
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
