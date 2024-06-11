//
//  NetworkManager.swift
//  MovieApp-Programmatic
//
//  Created by zeynep on 27.03.2024.
//

import Foundation

public typealias Completion<T> = (Result<T, APIClientError>) -> Void where T: Decodable
public final class NetworkManager<EndpointItem: Endpoint> {
    
   
    public func getMovies<T: Decodable>(type: T.Type, endpoint: EndpointItem, completion: @escaping Completion<T>) {
        guard let url = URL(string: endpoint.url) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            do {
                let decodedObject = try JSONDecoder().decode(type, from: data)
                completion(.success(decodedObject))
            } catch {
                let decodingError = APIClientError.decoding(error: error as? DecodingError)
                completion(.failure(decodingError))
                
            }
        }.resume()
    }
    
}
