//
//  StringExtension.swift
//  Movieland
//
//  Created by Dante Solorio on 05/05/21.
//

import Foundation

extension String {
    
    // MARK: - Additional functions
    
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
