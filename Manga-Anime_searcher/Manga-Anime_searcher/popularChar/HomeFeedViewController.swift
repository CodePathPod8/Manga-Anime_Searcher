//
//  HomeFeedViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse
import AlamofireImage


class HomeFeedViewController: UIViewController {

    
    var people = [[String:Any]]()
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.jikan.moe/v4/top/characters")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.people = dataDictionary["data"] as![[String: Any]]
                
                self.tableview.reloadData()
                print(dataDictionary)
               
            }
        }
        task.resume()
    }
    

  
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        
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

extension HomeFeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let peoples = people[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as? homeCell else {
            return UITableViewCell()
        }
        
        let imagepath = peoples["images"] as! [String:Any]
//
        let jpgImage = imagepath["jpg"] as! [String:Any]
        
        let imageurlPath = jpgImage["image_url"] as! String
        let imgUrl = URL(string: imageurlPath)
        cell.actorImage.af.setImage(withURL: imgUrl!)
        
        cell.actorName.text = peoples["name"] as? String
        
        cell.aboutLabel.text = peoples["about"] as? String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "homeInfoVC") as? homeInfoVC else {
            return
        }
        
        vc.people = [people[indexPath.row]]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
