//
//  ViewController.swift
//  Movieland
//
//  Created by Dante Solorio on 29/04/21.
//

import UIKit

class ViewController: UIViewController {

    let session = URLSessionProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        let endpoint = MoviesPopularEndpoints.popular        
        session.request(type: Popular.self, service: endpoint) { response in
            switch response {
            case .success(let popularMovies):
                print(popularMovies?.results.count ?? 0)
            case let .failure(error):
                print(error)
            }
        }
    }


}

