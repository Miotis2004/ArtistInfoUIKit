//
//  TitleViewController.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import UIKit

class TitleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameData: String!
    let vm = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "TitleTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "TitleCell")

        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.vm.callNetwork(name: nameData)
        self.vm.bind { [weak self] in
            print("Callback achieved")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleTableViewCell
        
        //let track = trackArray[indexPath.row]
        
        cell.artistName.text = self.vm.artistName(index: indexPath.row)
        cell.songTitle.text = self.vm.trackName(index: indexPath.row)
        cell.releaseDate.text = self.vm.releaseDate(index: indexPath.row)
        cell.genre.text = self.vm.genre(index: indexPath.row)
        cell.price.text = "$\(self.vm.price(index: indexPath.row))"
        
        return cell
    }
    
    

}
