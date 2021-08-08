//
//  MenuCollectionViewController.swift
//  BeerPub
//
//  Created by Евгений Березенцев on 07.08.2021.
//

import UIKit

class MenuCollectionViewController: UICollectionViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Sections,Beer>!
    private var networkManager = NetworkManager()
    private var beers: [Beer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        createDataSource()
        createSnapshot()
        updateData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let beerItem = dataSource.itemIdentifier(for: indexPath)
        performSegue(withIdentifier: "detailSegue", sender: beerItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController else { return  }
        detailVC.beerItem = sender as? Beer
    }
    
    private func updateData() {
        networkManager.fetchData {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let listOfBeers):
                    self.beers = listOfBeers
                    self.createSnapshot()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
        
    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections,Beer>()
        snapshot.appendSections([.main])
        snapshot.appendItems(beers)
        dataSource.apply(snapshot)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}

extension MenuCollectionViewController {
    
    //MARK: - DataSource
    private func createDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell,Beer> { cell, indexPath, beer in
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: "arrow.right.circle")
            content.text = beer.name
            content.secondaryText = beer.tagline
            cell.contentConfiguration = content
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = UICollectionViewDiffableDataSource<Sections,Beer>(collectionView: collectionView, cellProvider: { collectionView, index, beer in
            collectionView.dequeueConfiguredReusableCell(using: registration, for: index, item: beer)
        })
    }
    
    enum Sections {
        case main
    }

}

extension MenuCollectionViewController {
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
    }
}
 
