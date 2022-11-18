//
//  homeInfoCell.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/17/22.
//

import UIKit

class homeInfoCell: UITableViewCell {

    @IBOutlet weak var backdropimage: UIImageView!
    
    @IBOutlet weak var Charimage: UIImageView!
    
    @IBOutlet weak var nameCharLabel: UILabel!
    
    @IBOutlet weak var rankingLabel: UILabel!
   
    
    @IBOutlet weak var aboutCharLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
