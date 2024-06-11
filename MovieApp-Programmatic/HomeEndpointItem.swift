//
//  HomeEndpointItem.swift
//  MovieApp-Programmatic
//
//  Created by zeynep on 29.03.2024.
//

import Foundation

enum HomeEndpointItem: Endpoint {
    case homepage(query: String)
    var baseURL: String {"https://api.themoviedb.org/3/movie"}
    
    var path: String {"popular"}
    
    var apikey: String {"50383ab4cfd001efb2614c1ddd751aec"}
    
    var param: String {
        switch self {
        case .homepage(let query): return query
        }
    }
    
    var method: String { "GET"}
    
    
}
