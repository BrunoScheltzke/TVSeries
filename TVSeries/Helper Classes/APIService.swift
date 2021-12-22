//
//  APIService.swift
//  TVSeries
//
//  Created by Bruno Scheltzke on 21/12/21.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchTVSeries(pagination: Int, completion: @escaping(Result<[TVSeries], Error>) -> Void)
}

fileprivate let basePath = "https://api.tvmaze.com/"
fileprivate let tvSeriesPath = "\(basePath)shows"

struct APIService: APIServiceProtocol {
    func fetchTVSeries(pagination: Int, completion: @escaping(Result<[TVSeries], Error>) -> Void) {
        performGenericRequest(path: tvSeriesPath, method: .get, parameters: ["page": pagination], completion: completion)
    }
    
    private func performGenericRequest<T: Decodable, Parameters: Encodable>(path: String, method: HTTPMethod, parameters: Parameters? = nil, completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(path,
                   method: method,
                   parameters: parameters).responseDecodable { (dataResponse: DataResponse<T, AFError>) in
            switch dataResponse.result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
