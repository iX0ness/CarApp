//
//  Car.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

struct Car: Decodable {
    let id: Int
    var vin: String
    let model: String
    var doors: Int
    var kilometrage: Int
}
