//
//  MangaInfoVC.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/14/22.
//

import UIKit
import AlamofireImage

class MangaInfoVC: UIViewController {

    var categories = ["", "Popular Anime", "Latest Anime", "", "Action Anime"]
    var manga = [[String: Any]] ()
    
    
    @IBOutlet weak var infomangaTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infomangaTableview.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    

}

extension MangaInfoVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mangas = manga[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mangaInfoCell") as? mangaInfoCell else {
            return UITableViewCell()
        }
        cell.sypnosisLabel.text = mangas["synopsis"] as? String
        
        let imagepath = mangas["images"] as! [String:Any]
//
        let jpgImage = imagepath["jpg"] as! [String:Any]
        print(jpgImage,"prtting in the other vc")
        let imageurlPath = jpgImage["large_image_url"] as! String
        let imgUrl = URL(string: imageurlPath)
        
        //the below code access the trailer images within the Anime dict
        let trailerpath = mangas["images"] as! [String:Any]
        // the below coede access the images dict
        let trailerImage = trailerpath["webp"] as? [String:Any]
        //this access the final level of the dict
        if let trailerimageurlPath = (trailerImage!["image_url"] as? String){
            // converting the string into URL
            let trailerimgUrl = URL(string: trailerimageurlPath)
            // display images as backdrop
            cell.backdropimage.af.setImage(withURL:trailerimgUrl!)
        } else {
            cell.backdropimage.image = Image(named: "Searching")
            //add default image
        }
        
        
        
//
        let title = mangas["title"] as? String
        cell.mangaimage.af.setImage(withURL:imgUrl!)
        cell.mangtitleLabel.text = title
        
//        cell.epidNumLabel.text = animes["episodes"] as? String
        
        cell.rankingLabel.text = mangas["rating"] as? String
        navigationItem.title = categories[indexPath.row]
        
        return cell
    }
    
    
}
