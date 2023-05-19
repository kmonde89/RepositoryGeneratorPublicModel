//
//  Operation.swift
//  
//
//  Created by Kévin Mondésir on 19/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct Operation {
        public let function: Function
        public let requestConfiguration: RequestConfiguration
        public let response: Response
        
        public init(function: Function, requestConfiguration: RequestConfiguration, response: Response) {
            self.function = function
            self.requestConfiguration = requestConfiguration
            self.response = response
        }
    }
}
