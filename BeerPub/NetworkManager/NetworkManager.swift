//
//  NetworkManager.swift
//  BeerPub
//
//  Created by Евгений Березенцев on 07.08.2021.
//

import Foundation
import Alamofire


class NetworkManager {
    
    static var shared = NetworkManager()
        
    func fetchData(complition: @escaping (Result<[Beer],Error>) -> Void ) {
        let urlString = "https://api.punkapi.com/v2/beers?page=1&per_page=20"
        AF.request(urlString)
            .validate()
            .responseDecodable(of: [Beer].self) { response in
                switch response.result {
                case .success(let beers):
                    DispatchQueue.main.async {
                        complition(.success(beers))
                    }
                case .failure(let error):
                    complition(.failure(error))
                }
            }
    }
    
    
    func fetchImage(with urlString: String, completion: @escaping (Data)-> Void) {
        AF.request(urlString).validate().responseData { response in
            guard let data = response.data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
            
        }
    }
    
    private init() {}

}

