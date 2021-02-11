//
//  TitleTableViewCell.swift
//  ArtistInfoUIKit
//
//  Created by Ronald Joubert on 2/11/21.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var price: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
