//
//  DetailViewController.swift
//  BeerPub
//
//  Created by Евгений Березенцев on 07.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var beerItem: Beer!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        title = beerItem.name
        fetchImage(with: beerItem.image_url ?? "")
        descriptionLabel.text = beerItem.description
    }
    
    private func fetchImage(with urlString: String) {
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return  }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.beerImageView.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    



}
