import Foundation
import Path
import SwiftCLI

/// XDG Base Directory namespace.
/// https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
struct XDGBaseDirectory {
    var configHome: Path {
        guard let input = ProcessInfo.processInfo.environment["XDG_CONFIG_HOME"] else {
            return Path.home.join(".config")
        }
        return Path(input) ?? Path.cwd.join(input)
    }

    fileprivate init() {}
}

extension Path {
    static let XDG: XDGBaseDirectory = .init()
}

extension Path: ConvertibleFromString {
    public init?(input: String) {
        self = Path(input) ?? Path.cwd.join(input)
    }
}

extension Workspace: ConvertibleFromString {
    public init?(input: String) {
        self = input.split(separator: ".").map(String.init)
    }
}
