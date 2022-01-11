//
//  HeroViewModel.swift
//  DotaHeroCatalog
//
//  Created by Bayu Triharyanto on 09/01/22.
//

import Foundation
import RealmSwift

class HeroViewModel{
    var heroes = [Hero]()
    var dynamicHeroes = [Hero]()
    let realm = try! Realm()
    var dataModel : Results<DataModel>?
    
    func downloadJSON(completed: @escaping () -> ()){
        
        let url = URL(string: "https://api.opendota.com/api/herostats")
        
        if self.getUserDefault(){
            self.getDataFromLocal()
        }else{
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                if error == nil {
                    do {
                        self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                        self.dynamicHeroes = self.heroes
                        self.setUserDefaultLoadData(condition: true)
                        self.addToLocal()
                        DispatchQueue.main.async {
                            completed()
                        }
                        
                    } catch{
                        print("JSON Error")
                    }
                }
                
            }.resume()
        }
        
        
    }
    
    func filterHeroByAttribute(category: String) -> [Hero] {
        let hero = dynamicHeroes.filter({return $0.primary_attr.contains(category)})
        let sortedHero = hero.sorted { lhs, rhs in
            if category == "agi"{
                return lhs.move_speed > rhs.move_speed
            }
            else if category == "str"{
                return lhs.base_attack_max > rhs.base_attack_max
            }
            else{
                return lhs.base_mana > rhs.base_mana
            }
        }
        
        return sortedHero
    }
    
    func filterHeroByCategory(category: String) -> [Hero]{
        let hero = dynamicHeroes.filter({return $0.roles.contains(category.capitalized)})
        return hero
    }
    
    
    func addToLocal(){
        var heroArray : [DataModel] = []
        for hero in heroes {
            let newHero = DataModel()
            for heroRole in hero.roles{
                newHero.roles.append(heroRole)
            }
            
            newHero.id = hero.id
            newHero.img = hero.img
            newHero.localized_name = hero.localized_name
            newHero.primary_attr = hero.primary_attr
            newHero.base_mana = hero.base_mana
            newHero.base_attack_max = hero.base_attack_max
            newHero.base_attack_min = hero.base_attack_min
            newHero.move_speed = hero.move_speed
            newHero.base_health = hero.base_health
            
            
            DispatchQueue.main.async {
                do{
                    try self.realm.write({
                        self.realm.add(newHero)
                        print("berhasil save")
                    })
                }
                catch{
                    print("Error saving hero \(error)")
                }
            }
        }
        
    }
    
    func getDataFromLocal(){
        dataModel = realm.objects(DataModel.self)
        var dataHero: [Hero] = []
        guard let dataModel = dataModel else { return }
        for data in dataModel{
            var role : [String] = []
            for dataRole in data.roles{
                role.append(dataRole)
            }
            let heroData = Hero(id: data.id, img: data.img, localized_name: data.localized_name, primary_attr: data.primary_attr, attack_type: data.attack_type, roles: role, base_health: data.base_health, base_mana: data.base_mana, base_armor: data.base_armor, base_attack_min: data.base_attack_min, base_attack_max: data.base_attack_max, move_speed: data.move_speed)
            dataHero.append(heroData)
        }
        self.heroes = dataHero
        self.dynamicHeroes = dataHero
    }
    
    func filterCategoryFromLocal(roles: String){
        var dataHero: [Hero] = []
        dataModel = realm.objects(DataModel.self).filter("roless CONTAINS[cd] %@", roles)
        guard let dataModel = dataModel else { return }
        for data in dataModel{
            var role : [String] = []
            for dataRole in data.roles{
                role.append(dataRole)
            }
            let heroData = Hero(id: data.id, img: data.img, localized_name: data.localized_name, primary_attr: data.primary_attr, attack_type: data.attack_type, roles: role, base_health: data.base_health, base_mana: data.base_mana, base_armor: data.base_armor, base_attack_min: data.base_attack_min, base_attack_max: data.base_attack_max, move_speed: data.move_speed)
            dataHero.append(heroData)
        }
        self.heroes = dataHero
        self.dynamicHeroes = dataHero
    }
    
    func save(dataModel: [DataModel]){
        DispatchQueue.main.async {
            do{
                try self.realm.write({
                    self.realm.add(dataModel)
                    self.realm.add(dataModel)
                    print("berhasil save")
                })
            }
            catch{
                print("Error saving hero \(error)")
            }
        }
        
    }
    
    
    
    func setUserDefaultLoadData(condition: Bool){
        UserDefaults.standard.set(condition, forKey: "LoadData")
    }
    
    func getUserDefault() -> Bool {
        let isLoad = UserDefaults.standard.value(forKey: "LoadData") ?? false
        return isLoad as! Bool
        
    }
}

