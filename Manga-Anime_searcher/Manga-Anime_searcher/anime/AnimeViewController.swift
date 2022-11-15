//
//  AnimeViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse
import AlamofireImage

class AnimeViewController: UIViewController {
   
    var Animes = [[String: Any]] ()
    var latest = [[String: Any]] ()
    var upcoming = [[String: Any]] ()
    
  
    var categories = ["", "Popular Anime", "Latest Anime", "", "Upcoming Anime"]
    var clickedRow: Int?
    
    @IBOutlet weak var catagory: UILabel!
  

    
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
        let urls = URL(string: "https://api.jikan.moe/v4/seasons/2022/fall")!
        let requests = URLRequest(url: urls, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let sessions = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let tasks = sessions.dataTask(with: requests) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.latest = dataDictionary["data"] as![[String: Any]]
                
                self.tableView.reloadData()
                print(dataDictionary)
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        tasks.resume()
        let urls2 = URL(string: "https://api.jikan.moe/v4/seasons/upcoming")!
        let requests2 = URLRequest(url: urls2, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let sessions2 = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let tasks2 = sessions2.dataTask(with: requests2) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.upcoming = dataDictionary["data"] as![[String: Any]]
                
                self.tableView.reloadData()
//                print(dataDictionary)
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        tasks2.resume()
        
    
    
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

    func moveOnAnimeLatestList(index: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AnimeDetailListVC") as? AnimeDetailListVC else {
            return
        }
        //TODO: do we really need to pass data if you alread retrieve inside VC?
//        vc.latest = [latest[index]]
        
        vc.scenario = .latestAnime
        
//        vc.categories = [categories[index]]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveOnPopularAnime(index: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AnimeDetailListVC") as? AnimeDetailListVC else {
            return
        }
        //trying to make it so the see all loads the data from the different enpoints
        vc.scenario = .popularAnime
        navigationController?.pushViewController(vc, animated: true)
    }
    func moveOnUpcomingAnime(index: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "AnimeDetailListVC") as? AnimeDetailListVC else {
            return
        }
        //trying to make it so the see all loads the data from the different enpoints
        vc.scenario = .upcomingAnime
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveOnAnimeInfo(scenario: ScenarioType, cindex: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "animeInfoVC") as? animeInfoVC else {
            return
        }
        switch scenario {
        case .popularAnime:
            break
        case .latestAnime:
            break
        case .upcomingAnime:
            break
        }
//        if tindex == 2 {
//            vc.anime = [Animes[tindex]]
//        } else if tiindex == 3 {
//            vc.anime =
//        }
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension AnimeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Animes.count > 5 ? 5 : Animes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let anime = Animes[indexPath.row]
        if(indexPath.row == 0 || indexPath.row == 3)
        {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "BiggerCell") as! BiggerCell
            cell.summary.text = anime["synopsis"] as? String
            
        
            let imagepath = anime["images"] as! [String:Any]
//
            let jpgImage = imagepath["jpg"] as! [String:Any]
            
            let imageurlPath = jpgImage["large_image_url"] as! String
            let imgUrl = URL(string: imageurlPath)
//
            let title = anime["title"] as? String
            cell.Small_Image.af.setImage(withURL:imgUrl!)
            cell.Titles.text = title
            
            
            
            //the below code access the trailer images within the Anime dict
            let trailerpath = anime["trailer"] as! [String:Any]
            // the below coede access the images dict
            let trailerImage = trailerpath["images"] as? [String:Any]
            //this access the final level of the dict
            if let trailerimageurlPath = (trailerImage!["large_image_url"] as? String){
                // converting the string into URL
                let trailerimgUrl = URL(string: trailerimageurlPath)
                // display images as backdrop
                cell.BigImage.af.setImage(withURL:trailerimgUrl!)
            } else {
                cell.BigImage.image = Image(named: "Searching")
                //add default image
            }
            
            
            
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnimeTableCell
            cell.catagory.text = categories[indexPath.row]
            cell.AnimesTransferred = Animes
            if(indexPath.row == 2)
            {
                cell.AnimesTransferred = latest
            }
            else if(indexPath.row == 4)
            {
                cell.AnimesTransferred = upcoming
            }
            
            cell.index = indexPath.row
            cell.onClickSeeAllClosure = {
                index in
                if let indexp = index {
                    // Latest Section
                    if indexPath.row == 2
                    {
                        //navigate to latest list
                        self.moveOnAnimeLatestList(index: indexp)
                    }
                    // Upcoming Section
                    else if indexPath.row == 4
                    {
                        // Go to upcoming list
                        self.moveOnUpcomingAnime(index: indexp)
                        
                    } else if indexPath.row == 1 {
                        self.moveOnPopularAnime(index: indexp)
                    }
                }
            }
            
            cell.didSelectClosure = { tabindex, colindex in
                if let tabindex = tabindex, let colindex = colindex {
                    var scenario: ScenarioType = .popularAnime
                    if indexPath.row == 2
                    {
                        //navigate to latest list
                        scenario = .latestAnime
                    }
                    // Upcoming Section
                    else if indexPath.row == 4
                    {
                        // Go to upcoming list
                        scenario = .upcomingAnime
                    } else if indexPath.row == 1 {
                        scenario = .popularAnime
                    }
                    self.moveOnAnimeInfo(scenario: scenario,
                                         cindex: colindex)
                }
//                clickedRow = 
                print(tabindex!,colindex!)
            }
        
            
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0 || indexPath.row == 3)
        {
            return 360
        }
        else{
            return 300
        }
    }
}
