//
//  DetailHeroeViewController.swift
//  DotaHeroCatalog
//
//  Created by Bayu Triharyanto on 10/01/22.
//
import UIKit

class DetailHeroViewController: UIViewController{
    
    @IBOutlet weak var heroImg: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroRoles: UILabel!
    @IBOutlet weak var attackType: UIImageView!
    @IBOutlet weak var attack: CustomView!
    
    @IBOutlet weak var similarHero: UITableView!
    @IBOutlet weak var armor: CustomView!
    @IBOutlet weak var speed: CustomView!
    @IBOutlet weak var health: CustomView!
    @IBOutlet weak var mana: CustomView!
    @IBOutlet weak var attribute: CustomView!
    
    var hero: Hero?
    var heroVM = HeroViewModel()
    var sameAttributeHero: [Hero] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        similarHero.delegate = self
        similarHero.dataSource = self
        setupView()
        let nib = UINib(nibName: "AnotherHeroTableViewCell", bundle: nil)
        similarHero.register(nib, forCellReuseIdentifier: "AnotherHeroTableViewCell")
        sameAttributeHero.filter({ $0.localized_name != hero?.localized_name
            
        })
        
    }
    
    func setupView(){
        let roles = hero?.roles
        let joined = roles?.joined(separator: ", ")
        let baseURL = "https://api.opendota.com"
        let imgURL = baseURL + (hero?.img ?? "") ?? ""
        guard let newHero = hero else {return}
        
        self.heroName.text = hero?.localized_name
        self.heroRoles.text = joined
        self.heroImg.downloaded(from: imgURL)
        
        self.attack.attrLabel.text = "\(newHero.base_attack_min) - \(newHero.base_attack_max)"
        self.attack.attrImg.image = UIImage(named: "attack")
        self.armor.attrLabel.text = "\(newHero.base_armor)"
        self.armor.attrImg.image = UIImage(named: "armor")
        self.speed.attrLabel.text = "\(newHero.move_speed)"
        self.speed.attrImg.image = UIImage(named: "speed")
        
        self.health.attrLabel.text = "\(newHero.base_health)"
        self.health.attrImg.image = UIImage(named: "health")
        self.mana.attrLabel.text = "\(newHero.base_mana)"
        self.mana.attrImg.image = UIImage(named: "mana")
        self.attribute.attrLabel.text = "\(newHero.primary_attr)"
        self.attribute.attrImg.image = UIImage(named: "attr")
    }
    
}
