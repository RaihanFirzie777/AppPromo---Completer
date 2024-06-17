//
//  NetworkManager.swift
//  AppPromo
//
//  Created by admin on 6/17/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchPromos(completion: @escaping ([Promo]?, Error?) -> Void) {
        guard let url = URL(string: "https://demo5853970.mockable.io/promos") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjc1OTE0MTUwLCJleHAiOjE2Nzg1MDYxNTB9.TcIgL5CDZYg9o8CUsSjUbbUdsYSaLutOWni88ZBs9S8", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }
            
            do {
                let promoResponse = try JSONDecoder().decode(PromoResponse.self, from: data)
                completion(promoResponse.promos, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
