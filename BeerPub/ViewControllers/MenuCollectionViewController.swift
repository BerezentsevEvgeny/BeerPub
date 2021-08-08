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
        // self.clearsSelectionOnViewWillAppear = false
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
            content.image = UIImage(systemName: "dollarsign.circle")
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
    

    




    // MARK: UICollectionViewDataSource

//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        10
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//
//
//
//
//        return cell
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

