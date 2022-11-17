//
//  AnimeDetailVC.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/12/22.
//this is the VC to display the full list of latest,upcoming and popular animes

import UIKit
import AlamofireImage

enum ScenarioType {
    case popularAnime
    case latestAnime
    case upcomingAnime
}
class AnimeDetailListVC: UIViewController {

    var categories = ["", "Popular Anime", "Latest Anime", "", "Action Anime"]
    var scenarios : ScenarioType = .popularAnime
    
    //below is the tableview connectiong
    @IBOutlet weak var animeListTableview: UITableView!
    
    var animes = [[String: Any]] ()
    var latest = [[String: Any]] ()
    var upcoming = [[String: Any]] ()
    
    fileprivate func loadLatestAnimeData() {
        //latest animes
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
                
                self.animeListTableview.reloadData()
                print(dataDictionary,"this are the latest anime")
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        tasks.resume()
    }
    
    fileprivate func loadPopularAnimeData() {
        let url = URL(string: "https://api.jikan.moe/v4/top/anime?=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.animes = dataDictionary["data"] as! [[String: Any]]
                
                
                self.animeListTableview.reloadData()
                //the additional comment was added to help debug
                //                print(dataDictionary,"this is from detail viewcontroller")
                
            }
        }
        task.resume()
    }
    
    fileprivate func loadUpcomingAnimeData() {
        //latest animes
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
                
                self.animeListTableview.reloadData()
//                print(dataDictionary)
                
            }
        }
        tasks2.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate is used to allow the click on the item and datasource loads the data in the tableview
        animeListTableview.delegate = self
        animeListTableview.dataSource = self
        switch scenarios {
        case .popularAnime:
            loadPopularAnimeData()
        case .latestAnime:
            loadLatestAnimeData()
        case .upcomingAnime:
            loadUpcomingAnimeData()
        }
        
        // Do any additional setup after loading the view.
        
        
    }

   
}

extension AnimeDetailListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch scenarios {
        case .popularAnime:
            return animes.count
        case .latestAnime:
            return latest.count
        case .upcomingAnime:
            return upcoming.count
        }
    }
    
    func getDataForCell(_ index: Int) -> [String: Any] {
        switch scenarios {
        case .popularAnime:
            return animes[index]
        case .latestAnime:
            return latest[index]
        case .upcomingAnime:
            return upcoming[index]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataForCell = getDataForCell(indexPath.row)

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeListCell") as? AnimeListCell else {
            return UITableViewCell()
        }
        
        cell.sypnosisLabel.text = dataForCell["synopsis"] as? String
        
        let imagepath = dataForCell["images"] as! [String:Any]
//
        let jpgImage = imagepath["jpg"] as! [String:Any]
        
        let imageurlPath = jpgImage["large_image_url"] as! String
        let imgUrl = URL(string: imageurlPath)
//
        let title = dataForCell["title"] as? String
        cell.animeImage.af.setImage(withURL:imgUrl!)
        cell.animeTitleLabel.text = title
        
//        let epinum = anime["episodes"] as? Int
//        cell.epidNumLabel.text = epinum
        
        cell.ratingLabel.text = dataForCell["rating"] as? String
//        navigationItem.title = categories[indexPath.row]
        
        
        return cell
    }
    
    //the below is used so that when one of the item list is clicked it sends to the next VC where it display further info about that item.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "animeInfoVC") as? animeInfoVC else {
            return
        }
        
        switch scenarios{
            
        case .popularAnime:
            vc.anime = [animes[indexPath.row]]
        case .latestAnime:
            vc.anime = [latest[indexPath.row]]
        case .upcomingAnime:
            vc.anime = [upcoming[indexPath.row]]
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
