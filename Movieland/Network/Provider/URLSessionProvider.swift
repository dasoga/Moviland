//
//  URLSessionProvider.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import Foundation

final class URLSessionProvider: ProviderProtocol {
    
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T : Decodable {
        let request = URLRequest(service: service)

        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            let httpResponse = response as? HTTPURLResponse
            self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        
        task.resume()
    }
    
    private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> ()) {
        
        guard let response = response else { return completion(.failure(.noJSONData)) }
        
        if NetworkConstants.isSuccessStatusCode(statusCode: response.statusCode) {
            guard let data = data else {
                return completion(.failure(.noJSONData))
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                return completion(.success(model))
            } catch let error {
                print("Error: \(error)")
                return completion(.failure(.errorJSONData))
            }
        } else {
            // TODO: Manage errors
            return completion(.failure(.unknown))
        }
    }
}
