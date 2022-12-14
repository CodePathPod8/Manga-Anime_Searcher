//
//  animeInfoVC.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/13/22.
//

import UIKit
import AlamofireImage


//enum Scenario2Type {
//    case popularAnime
//    case latestAnime
//    case upcomingAnime
//}
class animeInfoVC: UIViewController {

    var categories = ["", "Popular Anime", "Latest Anime", "", "Action Anime"]
    var scenario : ScenarioType = .popularAnime
    
    @IBOutlet weak var infoTableview: UITableView!
    
    
    var anime = [[String: Any]] ()
    var latest = [[String: Any]] ()
    var upcoming = [[String: Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoTableview.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    



}

extension animeInfoVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch scenario {
        case .popularAnime:
            return anime.count
        case .latestAnime:
            return latest.count
        case .upcomingAnime:
            return upcoming.count
        }
//        return 1
    }
    
    func getDataForCell(_ index: Int) -> [String: Any] {
        switch scenario {
        case .popularAnime:
            return anime[index]
        case .latestAnime:
            return latest[index]
        case .upcomingAnime:
            return upcoming[index]
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataForCell = getDataForCell(indexPath.row)
//        let animes = anime[indexPath.row]
        print(dataForCell,"this is the info here")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "animeInfoCell") as? animeInfoCell else {
            return UITableViewCell()
        }
        //setting sypnosis to the data value
        //if
        cell.sypnosisLabel.text = (dataForCell["synopsis"] as? String)//{
            
        
        let imagepath = dataForCell["images"] as! [String:Any]
//
        let jpgImage = imagepath["jpg"] as! [String:Any]
//        print(jpgImage,"prtting in the other vc")
        let imageurlPath = jpgImage["large_image_url"] as! String
        let imgUrl = URL(string: imageurlPath)
        
        //the below code access the trailer images within the Anime dict
        let trailerpath = dataForCell["trailer"] as! [String:Any]
        // the below coede access the images dict
        let trailerImage = trailerpath["images"] as? [String:Any]
        //this access the final level of the dict
        if let trailerimageurlPath = (trailerImage!["large_image_url"] as? String){
            // converting the string into URL
            let trailerimgUrl = URL(string: trailerimageurlPath)
            // display images as backdrop
            cell.backdropimage.af.setImage(withURL:trailerimgUrl!)
        } else {
            cell.backdropimage.image = Image(named: "Searching")
            //add default image
        }
        
        
        
//
        let title = dataForCell["title"] as? String
        cell.animeimage.af.setImage(withURL:imgUrl!)
        cell.anititleLabel.text = title
        
//        cell.epidNumLabel.text = animes["episodes"] as? String
        
        let rank = String((dataForCell["rank"] as? Int ?? 0)!)
        cell.rankingLabel.text = rank
        
        let epinum = String((dataForCell["episodes"] as? Int ?? 0)!)
        cell.epidNumLabel.text = epinum
        
        cell.stattusLabel.text = dataForCell["status"] as? String
        navigationItem.title = categories[indexPath.row]
        
        return cell
    }
    
    
}
