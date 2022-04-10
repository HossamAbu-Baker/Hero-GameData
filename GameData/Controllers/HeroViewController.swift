//
//  HeroViewController.swift
//  GameData
//
//  Created by ALTO-SOLUTIONS on 24/03/2022.
//

import UIKit

class HeroViewController: UIViewController {

    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var atrbiteslabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var legs: UILabel!
    
    var heroOpject:Hero?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text=heroOpject?.localized_name ?? ""
        atrbiteslabel.text=heroOpject?.primary_attr ?? ""
        attackLabel.text=heroOpject?.attack_type ?? ""
        legs.text="\(heroOpject?.legs ?? 0)"
        
        var paseUrl="https://api.opendota.com"+(heroOpject?.img ?? "")
        let url = URL(string: paseUrl)
        imgPhoto.downloaded(from: url!)
        
        
        
    }
    


}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
