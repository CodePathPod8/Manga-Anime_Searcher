//
//  Manga_Bigger_Cell.swift
//  Manga-Anime_searcher
//
//  Created by Shankar Ale Magar on 10/30/22.
//

import UIKit

class Manga_Bigger_Cell: UITableViewCell {

    @IBOutlet weak var BiggerImage: UIImageView!
    
    @IBOutlet weak var SmallerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
