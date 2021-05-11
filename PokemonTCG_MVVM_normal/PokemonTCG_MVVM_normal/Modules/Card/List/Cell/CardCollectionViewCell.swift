//
//  CardCollectionViewCell.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 03/05/2021.
//

import UIKit
import SDWebImage

class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constantes
    static let kIdentifier = "CardCollectionViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imgCard: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadDataCard(card: Card){
        guard let image = card.images?.small else { return }
        imgCard.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "pokeball"))
    }

}
