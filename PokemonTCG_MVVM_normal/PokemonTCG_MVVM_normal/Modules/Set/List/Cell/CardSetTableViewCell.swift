//
//  CardSetTableViewCell.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 04/05/2021.
//

import UIKit
import SDWebImage

class CardSetTableViewCell: UITableViewCell {
    
    static let kIdentifier = "CardSetTableViewCell"
    
    @IBOutlet weak var imgCardSet: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadCell(cardSet: CardSet){
        lbName.text = cardSet.name
        if let image = cardSet.images?.logo {
            imgCardSet.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "pokeball"))
        }
    }
    
}
