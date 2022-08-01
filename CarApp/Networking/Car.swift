//
//  Car.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

struct Car: Decodable {
    let id: Int
    let model: String
    var doors: Int
    var kilometrage: Int
    var vin: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case model = "make_and_model"
        case doors
        case kilometrage
        case vin
    }
    
}
