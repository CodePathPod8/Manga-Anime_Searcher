//
//  MangaViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit

class MangaViewController: UIViewController {
    var categories = ["", "Popular", "Latest", "", "Action"]

    @IBOutlet weak var MangaTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MangaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0 || indexPath.row == 3)
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: "Manga_Bigger_cell") as! Manga_Bigger_Cell
            return cell
        }
        else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "Manga_Small_Cell", for: indexPath) as! MangaTableCell
            cell.MangaCategory.text = categories[indexPath.row]
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0 || indexPath.row == 3)
        {
            return 250
        }
        else{
            return 200
        }
    }
}
