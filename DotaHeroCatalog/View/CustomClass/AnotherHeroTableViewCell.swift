//
//  AnotherHeroTableViewCell.swift
//  DotaHeroCatalog
//
//  Created by Bayu Triharyanto on 10/01/22.
//

import UIKit

class AnotherHeroTableViewCell: UITableViewCell {

    @IBOutlet weak var heroIMGSimilar: UIImageView!
    var url: String = ""
    var heroData: Hero?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func getImageHero(){
        guard let heroData = heroData else {
            return
        }

        let baseURL = "https://api.opendota.com"
        let imgURL = baseURL + heroData.img
        if heroIMGSimilar != nil{
            self.heroIMGSimilar.downloaded(from: imgURL)
        }
        
    }
}
