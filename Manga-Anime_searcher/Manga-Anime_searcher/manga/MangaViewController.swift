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
    var categories = ["", "Popular Manga", "Latest Manga", "", "Action Manga"]
    
    var manga = [[String:Any]]()

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
                print(dataDictionary)
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
            }
        }
        task.resume()
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func moveOnMangaList(index: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MangaDetailListVC") as? MangaDetailListVC else {
            return
        }
        vc.mangas = [manga[index]]
        navigationController?.pushViewController(vc, animated: true)
    }
    func moveOnMangaInfo(tindex: Int,cindex: Int){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MangaInfoVC") as? MangaInfoVC else {
            return
        }
        vc.manga = [manga[tindex]]
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
            let imagepath = mangas["images"] as! [String:Any]
//
            let jpgImage = imagepath["jpg"] as! [String:Any]
            
            let imageurlPath = jpgImage["large_image_url"] as! String
            let imgUrl = URL(string: imageurlPath)
//
            let title = mangas["title"] as? String
            cell.SmallerImage.af.setImage(withURL:imgUrl!)
            cell.titleLabel.text = title
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
            
            cell.index = indexPath.row
            
            cell.onClickSeeAllMangaClosure = {
                index in if let indexp = index {
                    self.moveOnMangaList(index: indexp)
                }
            }
            
            cell.didSelectMangaClosure = { tabindex, colindex in if let tabindex = tabindex,let colindex = colindex {
                self.moveOnMangaInfo(tindex: tabindex, cindex: colindex)
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
