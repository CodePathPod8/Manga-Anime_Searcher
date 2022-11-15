//
//  MangaDetailListVC.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/14/22.
//

import UIKit
import AlamofireImage

class MangaDetailListVC: UIViewController {
    
    var categories = ["", "Popular Anime", "Latest Anime", "", "Action Anime"]
    
    //below is the tableview connectiong
    @IBOutlet weak var mangaTableView: UITableView!
    
    var mangas = [[String:Any]]()
    var latest = [[String: Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate is used to allow the click on the item and datasource loads the data in the tableview
        mangaTableView.delegate = self
        mangaTableView.dataSource = self
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

        // Do any additional setup after loading the view.
    }
    


}


extension MangaDetailListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let manga = mangas[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MangaListCell") as? MangaListCell else {
            return UITableViewCell()
        }
        
        cell.sypnosisLabel.text = manga["synopsis"] as? String
        
        let imagepath = manga["images"] as! [String:Any]
//
        let jpgImage = imagepath["jpg"] as! [String:Any]
        
        let imageurlPath = jpgImage["large_image_url"] as! String
        let imgUrl = URL(string: imageurlPath)
//
        let title = manga["title"] as? String
        cell.MangaImage.af.setImage(withURL:imgUrl!)
        cell.mangaTitleLabel.text = title
        
//        let epinum = anime["episodes"] as? Int
//        cell.epidNumLabel.text = epinum
        
        cell.ratingLabel.text = manga["rating"] as? String
//        navigationItem.title = categories[indexPath.row]
        
        
        return cell
    }
    //the below is used so that when one of the item list is clicked it sends to the next VC where it display further info about that item.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MangaInfoVC") as? MangaInfoVC else {
            return
        }
        vc.manga = [mangas[indexPath.row]]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
