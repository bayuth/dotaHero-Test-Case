//
//  Ext+DetailHeroViewController.swift
//  DotaHeroCatalog
//
//  Created by Bayu Triharyanto on 11/01/22.
//

import Foundation
import UIKit

extension DetailHeroViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherHeroTableViewCell", for: indexPath) as! AnotherHeroTableViewCell
        cell.heroData = sameAttributeHero[indexPath.row]
        cell.getImageHero()
        return cell
    }
    
    
}
