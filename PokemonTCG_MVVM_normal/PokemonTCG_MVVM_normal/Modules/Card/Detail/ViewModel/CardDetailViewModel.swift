//
//  CardDetailViewModel.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 03/05/2021.
//

import Foundation

class CardDetailViewModel {
    
    private let connectionManager = CardConnectionManager()
    var showData = { () -> () in }
    var card: Card? {
        didSet {
            showData()
        }
    }
    
    /* Función para obtener el detalle de una carta */
    func getDataCard(idCard: String) {
        connectionManager.getDetailCard(idCard: idCard)
        connectionManager.getDataCard = { () in
            self.card = self.connectionManager.dataCard
        }
    }
}
