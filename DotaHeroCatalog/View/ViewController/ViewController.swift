//
//  ViewController.swift
//  DotaHeroCatalog
//
//  Created by Bayu Triharyanto on 09/01/22.
//

import UIKit
import RealmSwift

//protocol SelectHeroDelegate{
//    func didSelectHero(image: UIImage, name: String, primary_attr: String, attack_type:String, )
//}

class ViewController: UIViewController {
    
    @IBOutlet weak var heroCollectionView: UICollectionView!
    @IBOutlet weak var roleTableView: UITableView!
    
//    var heroes = [Hero]()
    let heroVM = HeroViewModel()
    let realm = try! Realm()
    var dataModel : Results<DataModel>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        heroCollectionView.dataSource = self
        heroCollectionView.delegate = self
        roleTableView.delegate = self
        roleTableView.dataSource = self
        let nib = UINib(nibName: "HeroRoleTableViewCell", bundle: nil)
        roleTableView.register(nib, forCellReuseIdentifier: "HeroRoleTableViewCell")
        self.navigationItem.title = "All Heroes"
        
        heroVM.downloadJSON{
            DispatchQueue.main.async {
                self.heroCollectionView.reloadData()
            }
        }
        cekingConnection()
    }
    
    func cekingConnection(){
        if NetworkMonitor.shared.isConnected{
            
            print("you're connected")
        }
        else{
            let alert = UIAlertController(title: "No Connection", message: "Your phone is not connected to the network", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("you are not connected")
        }
    }
}


