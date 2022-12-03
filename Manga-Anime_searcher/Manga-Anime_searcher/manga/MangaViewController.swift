//
//  MangaViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit
import Parse
import AlamofireImage

class MangaViewController: UIViewController {
    var categories = ["", "Top/Popular Manga", "Random Manga", "", "Recommended Manga"]
    
    var manga = [[String:Any]]()
    var random = [String:Any]()
    var recommended = [[String:Any]]()
    @IBOutlet weak var MangaTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.jikan.moe/v4/top/manga?=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.manga = dataDictionary["data"] as![[String: Any]]
                
                self.MangaTableView.reloadData()
                print(self.manga,"this is manga")
              
            }
        }
        task.resume()
        let urls = URL(string: "https://api.jikan.moe/v4/random/manga")!
        let requests = URLRequest(url: urls, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let sessions = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let tasks = sessions.dataTask(with: requests) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                self.random = dataDictionary["data"] as! [String: Any]

                self.MangaTableView.reloadData()
                print(dataDictionary,"this is randon mangas")

            }
        }
        tasks.resume()
        let urls2 = URL(string: "https://api.jikan.moe/v4/recommendations/manga")!
        let requests2 = URLRequest(url: urls2, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let sessions2 = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let tasks2 = sessions2.dataTask(with: requests2) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.recommended = dataDictionary["data"] as![[String: Any]]
                
                self.MangaTableView.reloadData()
                print(self.recommended,"this is recommended")
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
    
    
    
    func moveOnMangaList(index: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MangaDetailListVC") as? MangaDetailListVC else {
            return
        }
        vc.scenario = .topManga
        navigationController?.pushViewController(vc, animated: true)
    }
    func moveOnRandomMangaList(index: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MangaDetailListVC") as? MangaDetailListVC else {
            return
        }
        vc.scenario = .randomManga
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveOnRecomMangaList(index: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MangaDetailListVC") as? MangaDetailListVC else {
            return
        }
        vc.scenario = .recomManga
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func moveOnMangaInfo(scenario: ScenarioMangaType,cindex: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MangaInfoVC") as? MangaInfoVC else {
            return
        }
        switch scenario {
        case .topManga:
            vc.manga = [manga[cindex]]
            vc.scenario = .topManga
        case .recomManga:
//            var recentry = [recommended[cindex]]
//            vc.recommended = [recentry[cindex]]
            vc.recommended = [recommended[cindex]]
            vc.scenario = .recomManga
        case .randomManga:
            vc.random = random
            vc.scenario = .randomManga
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
extension MangaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manga.count > 5 ? 5 : manga.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mangas = manga[indexPath.row]
        if(indexPath.row == 0 || indexPath.row == 3)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Manga_Bigger_cell") as! Manga_Bigger_Cell
            cell.summary.text = mangas["synopsis"] as? String
            //images for bigcell
            if let imagepath = (mangas["images"] as? [String:Any]){
                
                let jpgImage = imagepath["jpg"] as! [String:Any]
                
                let imageurlPath = jpgImage["large_image_url"] as! String
                let imgUrl = URL(string: imageurlPath)
                cell.SmallerImage.af.setImage(withURL:imgUrl!)
            } else if let recomendedimagepathList = mangas["entry"] as? [[String:Any]] {
 
            print(recomendedimagepathList,"this is rec imagepa")
                if let Recomimagepath = recomendedimagepathList.first,let imagePath = Recomimagepath["image"] as? [String:Any] {
                    //
                    let jpgImage = imagePath["jpg"] as! [String:Any]
                    
                    let imageurlPath = jpgImage["large_image_url"] as! String
                    let imgUrl = URL(string: imageurlPath)
                    cell.SmallerImage.af.setImage(withURL:imgUrl!)
                }
            }
//
            if let title = (mangas["title"] as? String){
                print(title,"t")
                cell.titleLabel.text = title
            } else if let recomTittle = mangas["entry"] as? [[String:Any]] {
                let it = recomTittle[0]["title"] as? String
                print(it,"que es esto?")
                cell.titleLabel.text = it
            }

            //the below code access the trailer images within the Anime dict
            let trailerpath = mangas["images"] as! [String:Any]
            // the below coede access the images dict
            let trailerImage = trailerpath["webp"] as? [String:Any]
            //this access the final level of the dict
            if let trailerimageurlPath = (trailerImage!["image_url"] as? String){
                // converting the string into URL
                let trailerimgUrl = URL(string: trailerimageurlPath)
                // display images as backdrop
                cell.BiggerImage.af.setImage(withURL:trailerimgUrl!)
            } else {
                cell.BiggerImage.image = Image(named: "Searching")
                //add default image
            }
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Manga_Small_Cell", for: indexPath) as! MangaTableCell
            cell.MangaCategory.text = categories[indexPath.row]
            cell.mangaTransferred = manga
            if indexPath.row == 2 {
//                cell.mangaTransferred = recommended
                cell.randomTransferred = random
            }
             else if indexPath.row == 4 {
                cell.mangaTransferred = recommended
            }
            
            cell.index = indexPath.row
            
            cell.onClickSeeAllMangaClosure = {
                index in if let indexp = index {
                    if indexPath.row == 2
                    {
                        self.moveOnRandomMangaList(index: indexp)
                    } else if indexPath.row == 1 {
                        self.moveOnMangaList(index: indexp)
                    } else if indexPath.row == 4 {
                        self.moveOnRecomMangaList(index: indexp)
                        
                    }
        
                }
            }
            
            cell.didSelectMangaClosure = { tabindex, colindex in if let tabindex = tabindex,let colindex = colindex {
                var sceranio: ScenarioMangaType = .topManga
                if indexPath.row == 2
                {
                    sceranio = .randomManga
                } else if indexPath.row == 1
                {
                    sceranio = .topManga
                } else if indexPath.row == 4
                {
                    sceranio = .recomManga
                    
                }
                self.moveOnMangaInfo(scenario: sceranio, cindex: colindex)
            }
            }
            
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


