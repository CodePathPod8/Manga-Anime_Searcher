//
//  MangaDetailListVC.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/14/22.
//

import UIKit
import AlamofireImage
//troubleshoot
enum ScenarioMangaType {
    case topManga
//    case randomManga
    case recomManga
}

class MangaDetailListVC: UIViewController {
    
    var categories = ["", "Popular Anime", "Latest Anime", "", "Action Anime"]
    //troubleshoto
    var scenario: ScenarioMangaType = .topManga
    
    //below is the tableview connectiong
    @IBOutlet weak var mangaTableView: UITableView!
    
    var mangas = [[String:Any]]()
    var random = [String:Any]()
    var recommended = [[String:Any]]()
    
    var entryManga = [[String:Any]] ()
    
    fileprivate func loadTopmangaData(){
        let url = URL(string: "https://api.jikan.moe/v4/top/manga?=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.mangas = dataDictionary["data"] as![[String: Any]]
                
                self.mangaTableView.reloadData()
                print(dataDictionary)
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        task.resume()
    }
    
    fileprivate func loadrandommangaData(){
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

                self.mangaTableView.reloadData()
                print(dataDictionary,"this is randon mangas")

            }
        }
        tasks.resume()
    }
    
    fileprivate func loadrecommendedmangaData(){
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
                
                self.mangaTableView.reloadData()
                print(dataDictionary,"this is recommended")
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        tasks2.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate is used to allow the click on the item and datasource loads the data in the tableview
        mangaTableView.delegate = self
        mangaTableView.dataSource = self
       
        switch scenario {
        case .topManga:
            loadTopmangaData()
//        case .randomManga:
//            loadrandommangaData()
        case .recomManga:
            loadrecommendedmangaData()
        }

        // Do any additional setup after loading the view.
    }
    
    
    


}


extension MangaDetailListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch scenario {
        case .topManga:
            return mangas.count
//        case .randomManga:
//            return random.count
        case .recomManga:
            return recommended.count
        }
        
//        return mangas.count
    }
    

    func getMangaDataCell(_ index: Int) -> [String:Any] {
        switch scenario {
        case .topManga:
            return mangas[index]
//        case .randomManga:
//            return random
        case .recomManga:
            return recommended[index]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataforcell = getMangaDataCell(indexPath.row)
//        let manga = mangas[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MangaListCell") as? MangaListCell else {
            return UITableViewCell()
        }
        if let sypnosi = (dataforcell["synopsis"] as? String) {
            cell.sypnosisLabel.text = sypnosi
        }else if let content = (dataforcell["content"] as? String) {
            cell.sypnosisLabel.text = content
        }

        
        if let imagepath = (dataforcell["images"] as? [String:Any]){
            
            let jpgImage = imagepath["jpg"] as! [String:Any]
            
            let imageurlPath = jpgImage["large_image_url"] as! String
            let imgUrl = URL(string: imageurlPath)
            cell.MangaImage.af.setImage(withURL:imgUrl!)
        } else if let recomendedimagepathList = dataforcell["entry"] as? [[String:Any]] {

        print(recomendedimagepathList,"this is rec imagepa")
            if let Recomimagepath = recomendedimagepathList.first,let imagePath = Recomimagepath["images"] as? [String:Any] {
                //
                let jpgImage = imagePath["jpg"] as! [String:Any]
                
                let imageurlPath = jpgImage["large_image_url"] as! String
                let imgUrl = URL(string: imageurlPath)
                cell.MangaImage.af.setImage(withURL:imgUrl!)
            }
        }
        if let title = (dataforcell["title"] as? String){
            cell.mangaTitleLabel.text = title
        } else if let recomTittle = dataforcell["entry"] as? [[String:Any]] {
            let it = recomTittle[0]["title"] as? String
            
            cell.mangaTitleLabel.text = it
        }
//        cell.MangaImage.af.setImage(withURL:imgUrl!)
//        cell.mangaTitleLabel.text = title
        
//        let epinum = String((dataforcell["episodes"] as? Int)!)
//        cell.epidNumLabel.text = epinum
        
        cell.statusLabel.text = dataforcell["status"] as? String
//        navigationItem.title = categories[indexPath.row]
        
//        let rank = String(((dataforcell["rank"] as? Int)!))
//
//        cell.rankinLabel.text = rank
//
        return cell
    }
    //the below is used so that when one of the item list is clicked it sends to the next VC where it display further info about that item.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MangaInfoVC") as? MangaInfoVC else {
            return
        }
        switch scenario{
        case .topManga:
            vc.manga = [mangas[indexPath.row]]
            vc.scenario = .topManga
        case .recomManga:
            vc.recommended = [recommended[indexPath.row]]
            vc.scenario = .recomManga
//        case .randomManga:
//            vc.random = random
//            vc.scenario = .randomManga
        }
//        vc.manga = [mangas[indexPath.row]]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
