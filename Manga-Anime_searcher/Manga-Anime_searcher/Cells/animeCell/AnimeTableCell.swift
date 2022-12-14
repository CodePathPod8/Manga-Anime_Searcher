//
//  AnimeTableCell.swift
//  Manga-Anime_searcher
//
//  Created by Shankar Ale Magar on 10/30/22.
//

import UIKit
import AlamofireImage


//the two alias below are use to display the the items when the see all btn is click and when then item inside the collection view is clicked
typealias DidSelectClosure = ((_ tableIndex: Int?,_ collectionIndex: Int?) -> Void)
typealias SeeAllClosure = ((_ tableIndex: Int?) -> Void)

class AnimeTableCell: UITableViewCell{
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    @IBOutlet weak var catagory: UILabel!
    
    var AnimesTransferred = [[String: Any]] ()
    
    var index: Int?
    var onClickSeeAllClosure: SeeAllClosure?
    var didSelectClosure: DidSelectClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        let width = collectionView.frame.size.width*2
        layout.itemSize = CGSize(width: width, height: 400)
        

    }
    
    //this is the btn See All
    @IBAction func onClickSeeAll(_ sender: Any) {
       onClickSeeAllClosure?(index)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension AnimeTableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let Anime = AnimesTransferred[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection_cell", for: indexPath) as? SmallcellCollection else {
            fatalError("Wrong cell class dequeued")
        }
        //the below code access the images within the Anime dict
        let imagepath = Anime["images"] as! [String:Any]
        // the below coede access the jpg dict
        let jpgImage = imagepath["jpg"] as! [String:Any]
        //this access the final level of the dict
        let imageurlPath = jpgImage["large_image_url"] as! String
        // converting the string into URL
        let imgUrl = URL(string: imageurlPath)
        // display images
        cell.AnimeImages.af.setImage(withURL:imgUrl!)

        cell.AnimeName.text = Anime["title"] as? String

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AnimesTransferred.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 149, height: 210)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // this is use when the item inside the collection view is click to display the specific item, this needs further improvement
        
        didSelectClosure?(index,indexPath.row)
    }
    
}
