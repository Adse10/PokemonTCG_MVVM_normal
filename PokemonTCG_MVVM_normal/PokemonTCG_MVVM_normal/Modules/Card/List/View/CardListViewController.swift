//
//  CardListViewController.swift
//  PokemonTCG_MVVM_normal
//
//  Created by Adrián Bolaños Ríos on 02/05/2021.
//

import UIKit

final class CardListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Propiedades
    var viewModel = CardListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Cargamos los datos
        loadData()
        // Registramos las celdas
        registersCells()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Funciones privadas
    
    private func loadData(){
        viewModel.getListCard()
        showData()
    }
    
    private func showData(){
        viewModel.refreshData = { () in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func registersCells(){
        collectionView.register(UINib(nibName: CardCollectionViewCell.kIdentifier, bundle: nil), forCellWithReuseIdentifier: CardCollectionViewCell.kIdentifier)
    }
    
    // MARK: - Scroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.bounds.size.height) {
            viewModel.addPage()
        }
    }
}



// MARK: - Extensions

extension CardListViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataListCard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.kIdentifier, for: indexPath) as! CardCollectionViewCell
        cell.loadDataCard(card: viewModel.dataListCard[indexPath.row])
        return cell
    }
    
    
}

extension CardListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let idCard = viewModel.dataListCard[indexPath.row].idCard else { return }
        let controller = CardDetailView(idCard: idCard)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CardListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: CGFloat(UIScreen.main.bounds.width / 3), height: CGFloat(UIScreen.main.bounds.width / 3) * 1.5)
    }
}
