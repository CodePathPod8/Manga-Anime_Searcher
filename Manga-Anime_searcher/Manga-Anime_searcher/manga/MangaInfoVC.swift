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
    var recommended = [[String:Any]]()
    var random = [String:Any]()
    
    var scenario: ScenarioMangaType = .topManga
    
    @IBOutlet weak var infomangaTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infomangaTableview.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    

}

extension MangaInfoVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch scenario {
        case .topManga:
            return manga.count
        case .randomManga:
            return random.count
        case .recomManga:
            return recommended.count
        }
        
//        return 1
    }
    
    func getMangaDataCell(_ index: Int) -> [String:Any] {
        switch scenario {
        case .topManga:
            return manga[index]
        case .randomManga:
            return random
        case .recomManga:
            return recommended[index]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataForCells = getMangaDataCell(indexPath.row)
        
//        let mangas = manga[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mangaInfoCell") as? mangaInfoCell else {
            return UITableViewCell()
        }
        cell.sypnosisLabel.text = dataForCells["synopsis"] as? String
        
//        let imagepath = dataForCells["images"] as! [String:Any]
////
//        let jpgImage = imagepath["jpg"] as! [String:Any]
//        print(jpgImage,"prtting in the other vc")
//        let imageurlPath = jpgImage["large_image_url"] as! String
//        let imgUrl = URL(string: imageurlPath)
//        cell.mangaimage.af.setImage(withURL:imgUrl!)
        if let imagepath = (dataForCells["images"] as? [String:Any]){
            
            let jpgImage = imagepath["jpg"] as! [String:Any]
            
            let imageurlPath = jpgImage["large_image_url"] as! String
            let imgUrl = URL(string: imageurlPath)
            cell.mangaimage.af.setImage(withURL:imgUrl!)
        } else if let recomendedimagepathList = dataForCells["entry"] as? [[String:Any]] {

        print(recomendedimagepathList,"this is rec imagepa")
            if let Recomimagepath = recomendedimagepathList.first,let imagePath = Recomimagepath["images"] as? [String:Any] {
                //
                let jpgImage = imagePath["jpg"] as! [String:Any]
                
                let imageurlPath = jpgImage["large_image_url"] as! String
                let imgUrl = URL(string: imageurlPath)
                cell.mangaimage.af.setImage(withURL:imgUrl!)
            }
        }
        
        if let trailerpath = (dataForCells["images"] as? [String:Any]){
            // the below coede access the images dict
            let trailerImage = trailerpath["webp"] as? [String:Any]
            
            //this access the final level of the dict
            let trailerimageurlPath = (trailerImage!["image_url"] as! String)
                // converting the string into URL
            let trailerimgUrl = URL(string: trailerimageurlPath)
            print(trailerimgUrl,"trailer imagen")
                // display images as backdrop
            cell.backdropimage.af.setImage(withURL:trailerimgUrl!)
        } else if let recomTrailerPathlist = dataForCells["entry"] as? [[String:Any]] {
                if let recomentrailerPath = recomTrailerPathlist.first, let imagepath = recomentrailerPath["images"] as? [String:Any]{
                    
                    let webpimage = imagepath["webp"] as! [String:Any]
                    
                    let trailerurlpath = webpimage["image_url"] as! String
                    let traiimgurl = URL(string: trailerurlpath)
                    print(traiimgurl,"trailer imagen in info")
                    cell.mangaimage.af.setImage(withURL: traiimgurl!)
                }
            
            } else {
                cell.backdropimage.image = Image(named: "Searching")
                //add default image
            }
//        }
//        //the below code access the trailer images within the Anime dict
//        let trailerpath = dataForCells["images"] as! [String:Any]
//        // the below coede access the images dict
//        let trailerImage = trailerpath["webp"] as? [String:Any]
//        //this access the final level of the dict
//        if let trailerimageurlPath = (trailerImage!["image_url"] as? String){
//            // converting the string into URL
//            let trailerimgUrl = URL(string: trailerimageurlPath)
//            // display images as backdrop
//            cell.backdropimage.af.setImage(withURL:trailerimgUrl!)
//        } else {
//            cell.backdropimage.image = Image(named: "Searching")
//            //add default image
//        }
        
        
        
        
        
        if let title = (dataForCells["title"] as? String){
            print(title, " in la info")
            cell.mangtitleLabel.text = title
        } else if let recomTittle = dataForCells["entry"] as? [[String:Any]] {
            let it = recomTittle[0]["title"] as? String
            print(title, " second else in la info")
            cell.mangtitleLabel.text = it
        }
//

        

        
//        cell.epidNumLabel.text = animes["episodes"] as? String
        
//        if cell.rankingLabel.text == (dataForCells["rating"] as? String){
//
//        }else {
//            cell.rankingLabel.text = "No ranking available"
//        }
        if let ranks = dataForCells["rank"] as? Int {
            cell.rankingLabel.text = "Number \(ranks)!"
        } else {
            cell.rankingLabel.text = "No ranking available"
        }
        
//        cell.rankingLabel.text = "Number \(ranks)!"
        navigationItem.title = categories[indexPath.row]
        
        return cell
    }
    
    
}
