//
//  homeInfoVC.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/17/22.
//

import UIKit
import AlamofireImage


class homeInfoVC: UIViewController {

    
    var people = [[String:Any]]()
    
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self

        // Do any additional setup after loading the view.
    }
    

  

}

extension homeInfoVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let peoples = people[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeInfoCell") as? homeInfoCell else {
            return UITableViewCell()
        }
        
        cell.aboutCharLabel.text = peoples["about"] as? String
        
        let imagepath = peoples["images"] as! [String:Any]
//
        let jpgImage = imagepath["jpg"] as! [String:Any]
        
        let imageurlPath = jpgImage["image_url"] as! String
        let imgUrl = URL(string: imageurlPath)
        cell.Charimage.af.setImage(withURL: imgUrl!)
        
        cell.nameCharLabel.text = peoples["name"] as? String
        
        let trailerpath = peoples["images"] as! [String:Any]
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
        
//        let arrt =  String((peoples["nicknames"] as? [Character]))
//        print(arrt)
//        cell.rankingLabel.text = arrt
        
        
        return cell
    }
    
    
}
