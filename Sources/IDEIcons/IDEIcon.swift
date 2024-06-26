#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

// TODO: expanded and condensed fonts (e.g. for “S” and “Pr” respectively)
// TODO: add array style
// TODO: better docs
// TODO: rethink API slightly — perhaps just a single `IDEIcon()` function which returns a platform image object?
// TODO: script for generating icon upfront?

///// Makes an icon.
// public func IDEIconMake() -> CGImage? { nil }

public enum IDEColorScheme : CaseIterable, Sendable {
    
    /// The color scheme that corresponds to a light appearance.
    case light
    
    /// The color scheme that corresponds to a dark appearance.
    case dark
}

/// The blueprint for an IDE icon.
public struct IDEIcon: Hashable {
    /// The icon’s content.
    public var content: IDEIconContent

    /// The icon’s color.
    public var color: IDEIconColor

    /// The icon’s color scheme.
    public var colorScheme: IDEColorScheme

    /// The icon’s style.
    public var style: IDEIconStyle

    /// The icon’s size.
    public var size: CGFloat

    /// Creates a new blueprint for an IDE icon.
    public init(_ text: String, color: IDEIconColor? = nil, colorScheme: IDEColorScheme? = nil, style: IDEIconStyle? = nil, size: CGFloat? = nil) {
        self.init(.text(text), color: color, colorScheme: colorScheme, style: style, size: size)
    }

    /// Creates a new blueprint for an IDE icon.
    public init(image: String, bundle: Bundle? = nil, color: IDEIconColor? = nil, colorScheme: IDEColorScheme? = nil, style: IDEIconStyle? = nil, size: CGFloat? = nil) {
        self.init(.image(image, bundle: bundle), color: color, colorScheme: colorScheme, style: style, size: size)
    }

    /// Creates a new blueprint for an IDE icon.
    public init(systemImage: String, color: IDEIconColor? = nil, colorScheme: IDEColorScheme? = nil, style: IDEIconStyle? = nil, size: CGFloat? = nil) {
        self.init(.systemImage(systemImage), color: color, colorScheme: colorScheme, style: style, size: size)
    }

    /// Creates a new blueprint for an IDE icon.
    public init(_ content: IDEIconContent, color: IDEIconColor? = nil, colorScheme: IDEColorScheme? = nil, style: IDEIconStyle? = nil, size: CGFloat? = nil) {
        self.content = content
        self.color = color ?? .purple
        self.colorScheme = colorScheme ?? .dark
        self.style = style ?? .default
        self.size = size ?? IDEIconSize.regular
    }
}

/// Specifies the content of an IDE icon.
public enum IDEIconContent: Hashable {
    /// Text content in the form of a string.
    case text(String)

    /// Image content.
    case image(String, bundle: Bundle?)

    /// System image content.
    case systemImage(String)

    //  /// Graphic content that is part of IDE Icons.
    //  case graphic(IDEIconGraphic)
}

///// Specifies the graphic of an IDE icon.
// public enum IDEIconGraphic: Hashable {
//  /// Three vertical bars, the middle one filled with the current accent color.
//  case threeBars
//
//  /// Three bulleted list items.
//  case list
//
//  /// The letter C with a line underneath.
//  case underlinedC
//
//  /// A bandage.
//  case bandage
// }

// TODO: rename default to bordered (and then outline to outlined?)?
// TODO: add shadow style (as seen in web inspector)

/// Specifies the style of an IDE icon.
///
/// ![](IDEIconStyle)
public enum IDEIconStyle: Int, CaseIterable {
    case `default`
    case outline
    case simple
    case simpleHighlighted

    // TODO: consider using this instead but then hashing won’t work automatically
    // (maybe add `isHighlighted` and a convenience `withHighlight()` to `IDEIcon` itself?
    //  case `default`, outline, simple(isHighlighted: Bool = false)
    //
    //  public static var allCases: [IDEIconStyle] {
    //    [.default, .outline, .simple(isHighlighted: false), .simple(isHighlighted: true)]
    //  }
}

extension IDEIconStyle {
    var fontWeight: PlatformFont.Weight {
        switch self {
        case .simple: return .semibold
        default: return .medium // .medium?
        }
    }

    var symbolFontWeight: PlatformFont.Weight {
        switch self {
        case .simple: return .semibold
        default: return .regular // .medium?
        }
    }

    #if !os(macOS)
    var symbolWeight: UIImage.SymbolWeight {
        switch self {
        case .simple: return .semibold
        default: return .regular // .medium?
        }
    }
    #endif
}
