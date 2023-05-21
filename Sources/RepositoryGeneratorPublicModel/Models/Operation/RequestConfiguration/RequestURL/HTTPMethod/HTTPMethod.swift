//
//  HTTPMethod.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public enum HTTPMethod: String, CaseIterable, Codable {
        case get
        case post
        case put
        case delete
        case patch
        case head
        case options
        case trace
    }
}
