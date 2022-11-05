//
//  AnimeViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse

class AnimeViewController: UIViewController {
    var categories = ["", "Popular Anime", "Latest Anime", "", "Action Anime"]
    @IBOutlet weak var catagory: UILabel!
    var Animes = [[String: Any]] ()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.jikan.moe/v4/top/anime?=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.Animes = dataDictionary["data"] as![[String: Any]]
                
                self.tableView.reloadData()
                print(dataDictionary)
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        task.resume()
    
    
    // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension AnimeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0 || indexPath.row == 3)
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: "BiggerCell") as! BiggerCell
            return cell
        }
        else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnimeTableCell
            cell.catagory.text = categories[indexPath.row] 
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0 || indexPath.row == 3)
        {
            return 330
        }
        else{
            return 270
        }
    }
}
