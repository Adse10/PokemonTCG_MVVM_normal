//
//  CardSetDetailViewController.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 04/05/2021.
//

import UIKit

class CardSetDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lbTitleName: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTitleOther: UILabel!
    @IBOutlet weak var lbOther: UILabel!
    
    
    // MARK: - Propiedades
    private var idSet: String?
    private let viewModel = CardSetDetailViewModel()
    
    // MARK: - Inits
    init(idSet: String){
        self.idSet = idSet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Estilos
        loadStyles()
        // Cargamos los datos
        loadData()
        // Do any additional setup after loading the view.
    }


    // MARK: - Funciones privadas
    
    private func loadStyles(){
        // Estilos titulos
        lbTitleName.font = UIFont.boldSystemFont(ofSize: 18)
        lbTitleOther.font = UIFont.boldSystemFont(ofSize: 18)
        // Textos
        lbTitleOther.text = "other.data".localize()
        lbTitleName.text = "name".localize()
    }
    
    private func loadData(){
        guard let idSet = idSet else { return }
        viewModel.getDetailSet(idSet: idSet)
        viewModel.showData = { () in
            self.showData()
        }
    }
    
    private func showData(){
        if let cardSet = viewModel.cardSet {
            DispatchQueue.main.async {
                self.lbName.text = cardSet.name
                self.lbOther.text = cardSet.releaseDate
            }
        }
    }
    

}
