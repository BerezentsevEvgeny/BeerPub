//
//  Beer.swift
//  BeerPub
//
//  Created by Евгений Березенцев on 07.08.2021.
//

import Foundation

struct Beer: Decodable,Hashable {
    let name: String?
    let description: String?
    let image_url: String?
    let tagline: String?
}
