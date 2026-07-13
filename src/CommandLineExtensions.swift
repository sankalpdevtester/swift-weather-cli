import Foundation

extension CommandLine {
    var arguments: [String] {
        return CommandLine.arguments
    }
    
    var location: String? {
        guard arguments.count > 1 else {
            return nil
        }
        return arguments[1]
    }
    
    var unit: String? {
        guard arguments.count > 2 else {
            return nil
        }
        return arguments[2]
    }
}