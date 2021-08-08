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
    @IBOutlet weak var beerCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var beerItem: Beer!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        beerCountLabel.text = Int(sender.value).description + " pcs"
    }
    
    @IBAction func addToOrderTapped() {
        let alert = UIAlertController(
            title: "Do you want to add \(beerCountLabel.text ?? "") \(beerItem.name ?? "")?",
            message: nil,
            preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let alertLabel = UIAlertController(title: "Thank you for order!", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertLabel.addAction(okAction)
            self.present(alertLabel, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func setupView() {
        title = beerItem.name
        fetchImage(with: beerItem.image_url ?? "")
        descriptionLabel.text = beerItem.description
        priceLabel.text = Int.random(in: 2...5).description + " $"
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
