//
//  CardListViewModel.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 02/05/2021.
//

import Foundation

final class CardListViewModel {
    
    var refreshData = { () -> () in }
    var dataListCard: [Card] = [] {
        didSet {
            refreshData()
        }
    }
    private let connectionManager = CardConnectionManager()
    private var page: Int = 1
    private var isLoadingPage = true
    private var otherPage = true
    
    func getListCard() {
        connectionManager.getListCard(page: page)
        connectionManager.getDataList = { () in
            self.processData(self.connectionManager.dataListCard)
        }
    }
    
    func addPage(){
        if !isLoadingPage && otherPage {
            page += 1
            isLoadingPage = true
            getListCard()
        }

    }
    
    private func processData(_ response: [Card]){
        isLoadingPage = false
        // Añadimos elemento al array
        if dataListCard.count != 0 {
            dataListCard += response
        }else{
            dataListCard = response
        }
        // Comprobamos si tenemos más paginas
        if response.count < 20 {
            otherPage = false
        }
    }
}
