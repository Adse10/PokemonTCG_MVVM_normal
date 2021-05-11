//
//  CardSetListViewModel.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 03/05/2021.
//

import Foundation

class CardSetListViewModel {
    
    var refreshData = { () -> () in }
    var dataListSet: [CardSet] = [] {
        didSet {
            refreshData()
        }
    }
    private var connectionManager = CardSetConnectionManager()
    private var page: Int = 1
    private var isLoadingPage = true
    private var otherPage = true
    
    /* Función para obtener el listado de sets */
    func getListSet() {
        connectionManager.getListSet(page: page)
        connectionManager.refreshDataList = { () in
            self.processData(self.connectionManager.dataListSet)
        }
    }
    
    /* Función para pedir la siguiente página */
    func addPage() {
        if !isLoadingPage && otherPage {
            page += 1
            isLoadingPage = true
            getListSet()
        }

    }
    
    private func processData(_ response: [CardSet]){
        isLoadingPage = false
        // Añadimos elemento al array
        if dataListSet.count != 0 {
            dataListSet += response
        }else{
            dataListSet = response
        }
        // Comprobamos si tenemos más paginas
        if response.count < 20 {
            otherPage = false
        }
    }
}
