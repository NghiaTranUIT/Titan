public protocol Parameter {
    var asString: String { get }
}

extension String: Parameter {
    public var asString: String {
        return self
    }
}

extension SignedInteger {
    public var asString: String {
        return "\(self)"
    }
}

extension FloatingPoint {
    public var asString: String {
        return "\(self)"
    }
}

extension DarwinBoolean {
    public var asString: String {
        return "\(self)"
    }
}

extension Bool: Parameter {}

extension Int: Parameter {}
extension Int16: Parameter {}
extension Int32: Parameter {}
extension Int64: Parameter {}

extension Float: Parameter {}
extension Double: Parameter {}
