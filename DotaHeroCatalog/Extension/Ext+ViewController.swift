//
//  Ext+ViewController.swift
//  DotaHeroCatalog
//
//  Created by Bayu Triharyanto on 11/01/22.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroVM.dynamicHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCollectionViewCell", for: indexPath) as! HeroCollectionViewCell
        cell.heroName?.text = heroVM.dynamicHeroes[indexPath.row].localized_name.capitalized ?? ""
        let baseURL = "https://api.opendota.com"
        let imgURL = baseURL + heroVM.dynamicHeroes[indexPath.row].img
        cell.heroImg.downloaded(from: imgURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailHeroStoryboard = UIStoryboard(name: "DetailHero", bundle: nil)
        let detailHero = detailHeroStoryboard.instantiateViewController(withIdentifier: "DetailHero") as! DetailHeroViewController
        detailHero.hero = heroVM.dynamicHeroes[indexPath.row]
        detailHero.heroVM = self.heroVM
        detailHero.sameAttributeHero = heroVM.filterHeroByAttribute(category: heroVM.dynamicHeroes[indexPath.row].primary_attr)
        self.navigationController?.pushViewController(detailHero, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroRoleTableViewCell", for: indexPath) as! HeroRoleTableViewCell
        cell.roleName?.text = roles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if roles[indexPath.row] == "All"{
            heroVM.dynamicHeroes = heroVM.heroes
            self.navigationItem.title = "All Heroes"
        }
        else{
            heroVM.dynamicHeroes = heroVM.filterHeroByCategory(category: roles[indexPath.row])
            self.navigationItem.title = "\(roles[indexPath.row].capitalized)"
        }
        
        self.heroCollectionView.reloadData()
    }
    
    
}
