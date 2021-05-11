//
//  CardSetConnectionManager.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 03/05/2021.
//

import Foundation

class CardSetConnectionManager {
    
    var refreshDataList = { () -> () in }
    var refreshDataSet = { () -> () in }
    var dataListSet: [CardSet] = [] {
        didSet {
            refreshDataList()
        }
    }
    var dataCardSet: CardSet? {
        didSet {
            refreshDataSet()
        }
    }
    
    /* Función para obtener el listado de sets */
    func getListSet(page: Int) {
        let session = URLSession.shared
        var components = URLComponents(string: Endpoints.main + Endpoints.listSet)
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
                    let result = try decoder.decode(ListSet.self, from: data)
                    self.dataListSet = result.data

                } catch let error {
                    print("Ha ocurrido un error: \(error.localizedDescription)")
                }
            }
            else if response.statusCode == 401 {
                print("Error 401")
            }
        }.resume()
    }
    
    /* Función para obtener el detalle de un set */
    func getDetailSet(idSet: String) {
        
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: Endpoints.main + Endpoints.detailSet + idSet)!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                return
            }
            
            if response.statusCode == 200 {
                do {
                    
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(DetailSet.self, from: data)
                    self.dataCardSet = result.data
                    
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
