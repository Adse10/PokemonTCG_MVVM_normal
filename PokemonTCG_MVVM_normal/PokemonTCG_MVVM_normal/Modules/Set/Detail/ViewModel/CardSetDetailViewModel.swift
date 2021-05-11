//
//  CardSetDetailViewModel.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 04/05/2021.
//

import Foundation

class CardSetDetailViewModel {
    
    private let connectionManager = CardSetConnectionManager()
    var showData = { () -> () in }
    var cardSet: CardSet? {
        didSet {
            showData()
        }
    }
    
    /* Función para obtener el detalle de un set */
    func getDetailSet(idSet: String){
        connectionManager.getDetailSet(idSet: idSet)
        connectionManager.refreshDataSet = { () in
            self.cardSet = self.connectionManager.dataCardSet
        }
    }
}
