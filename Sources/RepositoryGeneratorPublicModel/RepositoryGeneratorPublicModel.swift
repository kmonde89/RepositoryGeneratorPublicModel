public struct RepositoryGeneratorPublicModel {
    public init() {
    }
    
    enum ModelError: Error {
        case unknownParameter
    }
}

public func createPlaceHolder(_ text: String) -> String {
    return "<#T## \(text) ###".appending(">")
}

public func createIndentation(_ indentationLevel: UInt) -> String {
    return (0..<indentationLevel)
        .map { _ in "\t" }
        .joined()
}
