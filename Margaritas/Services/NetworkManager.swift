//
//  NetworkManager.swift
//  Margaritas
//
//  Created by Серёня on 11.08.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMargarita(from url: String) async throws -> Drink {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        guard let drink = try? decoder.decode(Drink.self, from: data) else { throw NetworkError.decodingError}
        
        return drink
    }
    
    func fetchImage(from url: String) async throws -> Data {
        guard let url = URL(string: url) else { throw NetworkError.invalidURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return data
    }
}

enum Link: String {
    case ritaAPI = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case noData
}
