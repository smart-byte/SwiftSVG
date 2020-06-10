import Foundation
import XMLCoder
import Swift2D

/// Generic element to define a shape.
///
/// A path is defined by including a ‘path’ element in a SVG document which contains a **d="(path data)"**
/// attribute, where the **‘d’** attribute contains the moveto, line, curve (both Cubic and Quadratic Bézier),
/// arc and closepath instructions.
///
/// ## Documentation
/// [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/path)
/// | [W3](https://www.w3.org/TR/SVG11/paths.html)
public class Path: Element {
    
    /// The definition of the outline of a shape.
    public var data: String = ""
    
    enum CodingKeys: String, CodingKey {
        case data = "d"
    }

    public override init() {
        super.init()
    }
    
    public convenience init(data: String) {
        self.init()
        self.data = data
    }
    
    public convenience init(commands: [Path.Command]) {
        self.init()
        data = commands.map({ $0.description }).joined()
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent(String.self, forKey: .data) ?? ""
    }
    
    // MARK: - CustomStringConvertible
    public override var description: String {
        return "<path d=\"\(data)\" \(super.description) />"
    }
}

// MARK: - DynamicNodeEncoding
extension Path: DynamicNodeEncoding {
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }
}

// MARK: - DynamicNodeDecoding
extension Path: DynamicNodeDecoding {
    public static func nodeDecoding(for key: CodingKey) -> XMLDecoder.NodeDecoding {
        return .attribute
    }
}

// MARK: - CommandRepresentable
extension Path: CommandRepresentable {
    public func commands() throws -> [Command] {
        return try PathProcessor(data: data).commands()
    }
}

// MARK: - Equatable
extension Path: Equatable {
    public static func == (lhs: Path, rhs: Path) -> Bool {
        do {
            let lhsCommands = try lhs.commands()
            let rhsCommands = try rhs.commands()
            return lhsCommands == rhsCommands
        } catch {
            return false
        }
    }
}
