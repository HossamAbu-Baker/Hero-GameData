//
//  ViewController.swift
//  GameData
//
//  Created by ALTO-SOLUTIONS on 23/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var hero = [Hero]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        data()
    }
    func data(){
        Reguest().loadData(url: "https://api.opendota.com/api/heroStats", response: [Hero].self) { response in
            switch response{
            case .success(let data):
                self.hero=data
                self.tableView.reloadData()
            case .failure(_):
                print("error")
            }
        }
        tableView.register(UINib(nibName: "HeroCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        hero.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)as!HeroCell
//
//        let opject = hero[indexPath.row]
//        cell.nameLabel.text = opject.localized_name ?? "hossam"
//
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         let vc = storyboard?.instantiateViewController(withIdentifier: "HeroViewController")as!HeroViewController
//        let opject = hero[indexPath.row]
//        vc.heroOpject = opject
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
}


extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hero.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)as!HeroCell
        
        let opject = hero[indexPath.row]
        cell.nameLabel.text = opject.localized_name ?? "hossam"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = storyboard?.instantiateViewController(withIdentifier: "HeroViewController")as!HeroViewController
        let opject = hero[indexPath.row]
        vc.heroOpject = opject
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
