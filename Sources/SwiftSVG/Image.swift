import Swift2D
import XMLCoder

/// The Image SVG element includes images inside SVG documents. It can display raster image files or other SVG files.
///
/// The values used for the x- and y-axis rounded corner radii are determined implicitly
/// if the ‘rx’ or ‘ry’ attributes (or both) are not specified, or are specified but with invalid values.
///
/// ## Documentation
/// [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/image)
public struct Image: ImageElement {

    /// The x-axis coordinate of the side of the rectangle which
    /// has the smaller x-axis coordinate value.
    public var x: Double = 0.0
    /// The y-axis coordinate of the side of the rectangle which
    /// has the smaller y-axis coordinate value
    public var y: Double = 0.0
    /// The width of the rectangle.
    public var width: Double = 0.0
    /// The height of the rectangle.
    public var height: Double = 0.0
    /// The String to use for the preserveAspectRatio attribute.
    public var preserveAspectRatio: String?
    /// The String to use for the xlink:href attribute.
    public var href: String = ""

    // CoreAttributes
    public var id: String?

    // StylingAttributes
    public var style: String?

    enum CodingKeys: String, CodingKey {
        case x
        case y
        case width
        case height
        case preserveAspectRatio
        case href
        case id
        case style
    }

    public init() {
    }

    public init(x: Double, y: Double, width: Double, height: Double, preserveAspectRatio: String? = nil,  href: String) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.preserveAspectRatio = preserveAspectRatio
        self.href = href
    }

    // MARK: - CustomStringConvertible
    public var description: String {
        var desc = "<image x=\"\(x)\" y=\"\(y)\" width=\"\(width)\" height=\"\(height)\""
        if let aspect = self.preserveAspectRatio {
            desc.append(" preserveAspectRatio=\"\(aspect)\"")
        }
        return desc + " \(attributeDescription) href=\"\(href)\" />"
    }
}

// MARK: - DynamicNodeEncoding
extension Image: DynamicNodeEncoding {
    public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
        return .attribute
    }
}

// MARK: - DynamicNodeDecoding
extension Image: DynamicNodeDecoding {
    public static func nodeDecoding(for key: CodingKey) -> XMLDecoder.NodeDecoding {
        return .attribute
    }
}
