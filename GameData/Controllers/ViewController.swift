//
//  ViewController.swift
//  GameData
//
//  Created by ALTO-SOLUTIONS on 23/03/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var hero = [Hero]()
    var filter : [Hero]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        data()
        searchBar.delegate = self
    }
    func data(){
        Reguest().loadData(url: "https://api.opendota.com/api/heroStats", response: [Hero].self) { [self] response in
            switch response{
            case .success(let data):
                hero = data
                filter = hero
                tableView.reloadData()
            case .failure(_):
                print("error")
            }
        }
        tableView.register(UINib(nibName: "HeroCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
    }
    
}


extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filter?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)as!HeroCell
        cell.selectionStyle = .none
        let opject = filter![indexPath.row]
        
        cell.dataPass(name: opject.localized_name ?? "")
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HeroViewController")as!HeroViewController
        let opject = hero[indexPath.row]
        
        vc.heroOpject = opject
        vc.xdelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
// MARK: Search

extension ViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == ""{
            filter = hero
        }
        else {
            filter = hero.filter({
                $0.localized_name!.lowercased().contains(searchText.lowercased())
            })
        }
        tableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filter = hero
        tableView.reloadData()
    }
}
// MARK: Protocol
extension ViewController : titleDelegate{
    func addTitle(name:String) {
        title = name
        view.backgroundColor = .systemRed
        
    }
    
    
}
