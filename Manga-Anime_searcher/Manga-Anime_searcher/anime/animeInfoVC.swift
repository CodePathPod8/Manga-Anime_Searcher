//
//  animeInfoVC.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/13/22.
//

import UIKit

class animeInfoVC: UIViewController {

    var categories = ["", "Popular Anime", "Latest Anime", "", "Action Anime"]
    
    @IBOutlet weak var infoTableview: UITableView!
    
    
    var anime = [[String: Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoTableview.dataSource = self
        let url = URL(string: "https://api.jikan.moe/v4/top/anime?=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.anime = dataDictionary["data"] as![[String: Any]]
                
                
                self.infoTableview.reloadData()
                print(dataDictionary,"this is from info viewcontroller")
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        task.resume()

        // Do any additional setup after loading the view.
    }
    



}

extension animeInfoVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let animes = anime[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeListCel") as? AnimeListCell else {
            return UITableViewCell()
        }
        cell.sypnosisLabel.text = animes["synopsis"] as? String
        
        let imagepath = animes["images"] as! [String:Any]
//
        let jpgImage = imagepath["jpg"] as! [String:Any]
        
        let imageurlPath = jpgImage["large_image_url"] as! String
        let imgUrl = URL(string: imageurlPath)
//
        let title = animes["title"] as? String
        cell.animeImage.af.setImage(withURL:imgUrl!)
        cell.animeTitleLabel.text = title
        
        cell.epidNumLabel.text = animes["episodes"] as? String
        
        cell.ratingLabel.text = animes["rating"] as? String
        navigationItem.title = categories[indexPath.row]
        return cell
    }
    
    
}
