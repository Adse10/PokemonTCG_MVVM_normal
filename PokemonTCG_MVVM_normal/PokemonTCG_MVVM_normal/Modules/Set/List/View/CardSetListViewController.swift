//
//  CardSetListViewController.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 03/05/2021.
//

import UIKit

class CardSetListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Propiedades
    private let viewModel = CardSetListViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Registramos las celdas
        registerCells()
        // Pedimos datos
        loadData()
    }
    
    // MARK: - Funciones privadas
    
    private func registerCells(){
        tableView.register(UINib(nibName: CardSetTableViewCell.kIdentifier, bundle: nil), forCellReuseIdentifier: CardSetTableViewCell.kIdentifier)
    }
    
    private func loadData(){
        viewModel.getListSet()
        showData()
    }
    
    private func showData(){
        viewModel.refreshData = { ()  in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.bounds.size.height){
            viewModel.addPage()
        }
    }

}
// MARK: - Extensions

extension CardSetListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.dataListSet.count > 0, let idSet = viewModel.dataListSet[indexPath.row].idSet else { return }
        let controller = CardSetDetailViewController(idSet: idSet)
        navigationController?.pushViewController(controller, animated:true)
    }
}

extension CardSetListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataListSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardSetTableViewCell.kIdentifier, for: indexPath) as! CardSetTableViewCell
        if viewModel.dataListSet.count > 0 {
            cell.loadCell(cardSet: viewModel.dataListSet[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    
}


