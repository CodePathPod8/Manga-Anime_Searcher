//
//  animeInfoCell.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/14/22.
//

import UIKit

class animeInfoCell: UITableViewCell {

    @IBOutlet weak var backdropimage: UIImageView!
    
    @IBOutlet weak var animeimage: UIImageView!
    
    @IBOutlet weak var anititleLabel: UILabel!
    
    @IBOutlet weak var rankingLabel: UILabel!
   
    
    @IBOutlet weak var sypnosisLabel: UILabel!
    
    @IBOutlet weak var epidNumLabel: UILabel!
    
    
    @IBOutlet weak var stattusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
