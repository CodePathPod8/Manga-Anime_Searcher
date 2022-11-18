//
//  MangaTableCell.swift
//  Manga-Anime_searcher
//
//  Created by Shankar Ale Magar on 10/30/22.
//

import UIKit
import AlamofireImage

//the two alias below are use to display the the items when the see all btn is click and when then item inside the collection view is clicked
typealias DidSelectMangaClosure = ((_ tableIndex: Int?,_ collectionIndex: Int?) -> Void)
typealias SeeAllMangaClosure = ((_ tableIndex: Int?) -> Void)

class MangaTableCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var MangaCategory: UILabel!
    
    var mangaTransferred = [[String:Any]] ()
    
    var randomTransferred = [String:Any] ()
    
    var index: Int?
    var onClickSeeAllMangaClosure: SeeAllMangaClosure?
    var didSelectMangaClosure: DidSelectMangaClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        let width = collectionView.frame.size.width*2
        layout.itemSize = CGSize(width: width, height: 300)
    }
    
    //this is the btn See All

    @IBAction func onClickSeeAll(_ sender: Any) {
        onClickSeeAllMangaClosure?(index)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension MangaTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let manga = mangaTransferred[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Manga_Collection_cell", for: indexPath) as? MangasmalCollectionCell else {
            fatalError("Wrong cell class dequeueed for manga")
        }
//        //the below code access the images within the Anime dict
//        let imagepath = manga["images"] as! [String:Any]
//        // the below coede access the jpg dict
//        let jpgImage = imagepath["jpg"] as! [String:Any]
//        //this access the final level of the dict
//        let imageurlPath = jpgImage["large_image_url"] as! String
//        // converting the string into URL
//        let imgUrl = URL(string: imageurlPath)
//        // display images
//        cell.mangaImage.af.setImage(withURL:imgUrl!)

        cell.mangaTitleLabel.text = manga["title"] as? String
    
        if let imagepath = (manga["images"] as? [String:Any]){
            let recomendedimagepath = manga["entry"] as? [[String:Any]]
            
            let jpgImage = imagepath["jpg"] as! [String:Any]
            
            let imageurlPath = jpgImage["large_image_url"] as! String
            let imgUrl = URL(string: imageurlPath)
            cell.mangaImage.af.setImage(withURL:imgUrl!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 149, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // this is use when the item inside the collection view is click to display the specific item, this needs further improvement
        
        didSelectMangaClosure?(index,indexPath.row)
    }
}

