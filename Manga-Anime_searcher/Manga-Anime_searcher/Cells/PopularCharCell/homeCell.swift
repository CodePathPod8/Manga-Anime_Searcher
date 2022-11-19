//
//  homeCell.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/17/22.
//

import UIKit

class homeCell: UITableViewCell {

    @IBOutlet weak var actorName: UILabel!
    
    @IBOutlet weak var actorImage: UIImageView!
    
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
