//
//  NetworkManager.swift
//  BeerPub
//
//  Created by Евгений Березенцев on 07.08.2021.
//

import Foundation
import Alamofire


class NetworkManager {
        
    func fetchData(complition: @escaping (Result<[Beer],Error>) -> Void ) {
//        let urlString = "https://api.punkapi.com/v2/beers?page=1&per_page=20"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print(error ?? "No error description")
//                return }
//            do {
//                let beers = try JSONDecoder().decode([Beer].self, from: data)
//                complition(.success(beers))
//            } catch let error {
//                complition(.failure(error))
//            }
//        }
//        .resume()
//    }
        let urlString = "https://api.punkapi.com/v2/beers?page=1&per_page=20"
        AF.request(urlString)
            .validate()
            .responseDecodable(of: [Beer].self) { response in
                switch response.result {
                case .success(let beers):
                    complition(.success(beers))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
        
        
        
        
    }

}
