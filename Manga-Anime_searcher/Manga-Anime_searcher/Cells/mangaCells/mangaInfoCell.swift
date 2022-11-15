//
//  mangaInfoCell.swift
//  Manga-Anime_searcher
//
//  Created by Yunior Sanchez on 11/14/22.
//

import UIKit

class mangaInfoCell: UITableViewCell {
    
    @IBOutlet weak var backdropimage: UIImageView!
    
    @IBOutlet weak var mangaimage: UIImageView!
    
    @IBOutlet weak var mangtitleLabel: UILabel!
    
    @IBOutlet weak var rankingLabel: UILabel!
   
    
    @IBOutlet weak var sypnosisLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
