//
//  APIClient.swift
//  CarApp
//
//  Created by Mykhaylo Levchuk on 29/07/2022.
//

import Foundation

enum APIError: Error {
    case dataFailure
    case responseFailure
    case decodingFailure
    case networkError(Error)
}

enum APIClient {
    private static let url = URL(string: "https://random-data-api.com/api/vehicle/random_vehicle")!
    
    static func fetchCar(completion: @escaping (Result<Car, APIError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if response == nil {
                completion(.failure(.responseFailure))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataFailure))
                return
            }
            
            do {
                let car = try JSONDecoder().decode(Car.self, from: data)
                completion(.success(car))
            } catch {
                completion(.failure(.decodingFailure))
            }
        }
    }
    
}
