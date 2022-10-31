//
//  AnimeViewController.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 10/22/22.
//

import UIKit

class AnimeViewController: UIViewController {
    var categories = ["", "Popular", "Latest", "", "Action"]
    @IBOutlet weak var catagory: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
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

extension AnimeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0 || indexPath.row == 3)
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: "BiggerCell") as! BiggerCell
            return cell
        }
        else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnimeTableCell
            cell.catagory.text = categories[indexPath.row] 
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
