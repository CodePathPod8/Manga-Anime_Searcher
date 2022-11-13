//
//  AnimeDetailVC.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/12/22.
//

import UIKit
import AlamofireImage

class AnimeDetailListVC: UIViewController {

    var categories = ["", "Popular Anime", "Latest Anime", "", "Action Anime"]
    
    @IBOutlet weak var animeListTableview: UITableView!
    
    var animes = [[String: Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animeListTableview.delegate = self
        animeListTableview.dataSource = self
        
        let url = URL(string: "https://api.jikan.moe/v4/top/anime?=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.animes = dataDictionary["data"] as![[String: Any]]
                
                
                self.animeListTableview.reloadData()
                print(dataDictionary,"this is from detail viewcontroller")
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
        
    }

   
}

extension AnimeDetailListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let anime = animes[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeListCell") as? AnimeListCell else {
            return UITableViewCell()
        }
        
        cell.sypnosisLabel.text = anime["synopsis"] as? String
        
        let imagepath = anime["images"] as! [String:Any]
//
        let jpgImage = imagepath["jpg"] as! [String:Any]
        
        let imageurlPath = jpgImage["large_image_url"] as! String
        let imgUrl = URL(string: imageurlPath)
//
        let title = anime["title"] as? String
        cell.animeImage.af.setImage(withURL:imgUrl!)
        cell.animeTitleLabel.text = title
        
//        let epinum = anime["episodes"] as? Int
//        cell.epidNumLabel.text = epinum
        
        cell.ratingLabel.text = anime["rating"] as? String
//        navigationItem.title = categories[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "animeInfoVC") as? animeInfoVC else {
            return
        }
        vc.anime = [animes[indexPath.row]]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
