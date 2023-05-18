//
//  Function.swift
//  
//
//  Created by Kévin Mondésir on 18/05/2023.
//

import Foundation

extension RepositoryGeneratorPublicModel {
    public struct Function {
        public let name: String
        public let parameters: [Parameter]
        public let returnValue: ReturnValue
        
        public init(name: String, parameters: [Parameter], returnValue: ReturnValue) {
            self.name = name
            self.parameters = parameters
            self.returnValue = returnValue
        }
        
        public var capitalizedName: String {
            return self.name.prefix(1).capitalized + self.name.dropFirst()
        }
        
        public var description: String {
            let parameters = self.parameters.signatureDescription()
            return "func \(self.name)(\(parameters)) -> \(returnValue.description)"
        }
    }
}
