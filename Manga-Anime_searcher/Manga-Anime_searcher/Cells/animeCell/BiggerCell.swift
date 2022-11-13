//
//  BiggerCell.swift
//  Manga-Anime_searcher
//
//  Created by Shankar Ale Magar on 10/30/22.
//

import UIKit

class BiggerCell: UITableViewCell {

    @IBOutlet weak var summary: UILabel!
    
    
    @IBOutlet weak var Small_Image: UIImageView!
    @IBOutlet weak var BigImage: UIImageView!
    
    @IBOutlet weak var Titles: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
