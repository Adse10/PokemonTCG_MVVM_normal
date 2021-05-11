//
//  CardConnectionManager.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 02/05/2021.
//

import Foundation

class CardConnectionManager {
    
    var getDataList = { () -> () in }
    var getDataCard = { () -> () in }
    // Fuente de datos de listado de cartas (Array)
    var dataListCard: [Card] = [] {
        didSet {
            getDataList()
        }
    }
    // Fuente de dato de detalle de una carta
    var dataCard: Card? {
        didSet {
            getDataCard()
        }
    }
    
    /* Función para obtener el listado de cartas */
    func getListCard(page: Int) {
        
        let session = URLSession.shared
        var components = URLComponents(string: Endpoints.main + Endpoints.listCard)
        components?.queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pageSize", value: "20")
        ]
        
        var request = URLRequest(url: (components?.url)!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200 {
                do {
                    
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Cards.self, from: data)
                    self.dataListCard = result.cards
                    
                } catch let error {
                    
                
                    print("Ha ocurrido un error: \(error.localizedDescription)")
                }
            }
            else if response.statusCode == 401 {
                print("Error 401")
            }
        }.resume()
    }
    
    /* Función para obtener el detalle de una tarjeta */
    func getDetailCard(idCard: String) {
        
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: Endpoints.main + Endpoints.detailCard + idCard)!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200 {
                do {
                    
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CardDetail.self, from: data)
                    self.dataCard = result.card
                    
                } catch let error {
                    
                    print("Ha ocurrido un error: \(error.localizedDescription)")
                }
            }
            else if response.statusCode == 401 {
                print("Error 401")
            }
        }.resume()
    }
}
