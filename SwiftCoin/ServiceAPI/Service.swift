//
//  Service.swift
//  SwiftCoin
//
//  Created by Diggo Silva on 10/12/23.
//

import Foundation

struct Service {
    
    let baseUrlUS = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=en"
    let baseUrlBR = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=brl&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h&locale=pt"
    
    static let shared = Service()
    
    private init() {}
    
    func fetchCoinData(completion: @escaping([Coin]) -> Void) {
        guard let url = URL(string: baseUrlBR) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else { return }
            
            if let response = response as? HTTPURLResponse {
                print("DEBUG: Response Code \(response.statusCode)")
            }
            
            do {
                let coinResult = try JSONDecoder().decode([Coin].self, from: data)
                completion(coinResult)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
//    func fetchCoinData() {
//        guard let url  = URL(string: baseUrlBR) else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("DEBUG: Error \(error.localizedDescription)")
//                return
//            }
//            
//            if let response = response as? HTTPURLResponse {
//                print("DEBUG: Response code \(response.statusCode)")
//            }
//            
//            guard let data = data else { return }
////            let dataAsString = String(data: data, encoding: .utf8)
////                print("DEBUG: Data \(dataAsString)")
//            
//            do {
//                let coins = try JSONDecoder().decode([Coin].self, from: data)
//                print("DEBUG: Coins \(coins)")
//            } catch let error {
//                print("DEBUG: Falha ao decodificar com o erro: \(error)")
//            }
//        }.resume()
//    }
}
