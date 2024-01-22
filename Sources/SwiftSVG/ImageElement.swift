public protocol ImageElement: CoreAttributes, StylingAttributes {
}

public extension ImageElement {
    var attributeDescription: String {
        var components: [String] = []

        if !coreDescription.isEmpty {
            components.append(coreDescription)
        }
        if !stylingDescription.isEmpty {
            components.append(stylingDescription)
        }

        return components.joined(separator: " ")
    }
}
