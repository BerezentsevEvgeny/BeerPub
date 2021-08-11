//
//  DataManager.swift
//  BeerPub
//
//  Created by Евгений Березенцев on 11.08.2021.
//

import Foundation

class DataManager {
    
    static var shared = DataManager()
    
    var orderedItems: [Beer] = []
    
    
    private init() {}
}
