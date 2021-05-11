//
//  CardDetailView.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 03/05/2021.
//

import UIKit

class CardDetailView: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var lbTitleName: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTitleOther: UILabel!
    @IBOutlet weak var lbOther: UILabel!
    
    
    // MARK: - Propiedades
    private var idCard: String?
    private var viewModel = CardDetailViewModel()
    
    init(idCard: String){
        self.idCard = idCard
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Estilos
        loadStyles()
        // Cargamos el dato
        loadData()
    }
    
    // MARK: - Funciones privadas
    private func loadStyles(){
        lbTitleName.font = UIFont.boldSystemFont(ofSize: 18)
        lbTitleOther.font = UIFont.boldSystemFont(ofSize: 18)
        // Textos
        lbTitleOther.text = "other.data".localize()
        lbTitleName.text = "name".localize()
    }
    
    private func loadData(){
        guard let idCard = idCard else { return }
        viewModel.getDataCard(idCard: idCard)
        viewModel.showData = { () in
            self.showData(card: self.viewModel.card)
        }
        
    }
    
    private func showData(card: Card?) {
        guard let card = card else { return }
        DispatchQueue.main.async {
            self.lbName.text = card.name
            self.lbOther.text = card.number
            if let image = card.images?.large {
                self.imgCard.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "pokeball"))
            }
        }
    }

}
