#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

extension IDEIcon {
    var fontWeight: PlatformFont.Weight {
        switch content {
        case let .text(string):
            switch string {
            case "#": return .light
            case "Ti": return .regular
            default: break
            }

        default:
            break
        }

        return style.fontWeight
    }

    var fontSizeAdjustment: CGFloat {
        switch content {
        case let .text(string):
            switch string {
            case "@": return 1
            case "{}": return -1
            // case "#": return 2.5
            // case "Ti": return 0.5
            case "⨍": return 0
            case "•": return 2.5
            default: break
            }

        case let .systemImage(name):
            switch name {
            case "puzzlepiece.fill": return -1
            case "rectangle.connected.to.line.below": return -0.1
            default: break
            }

        default:
            break
        }

        return 0
    }

    var yOffsetAdjustment: CGFloat {
        switch content {
        case let .text(string):
            if size <= IDEIconSize.regular {
                switch string {
                case "@": return 1
                case "#": return 0
                case "{}": return 0
                case "⨍": return 1
                // case "􀩲": xOffset = 0.5
                case "•": return 1
                //      case "Ti": return -2
                default: break
                }
            } else {
                switch string {
                case "@": return 3
                case "#": return 0
                case "•": return 3
                case "{}": return 2
                case "⨍": return 3.5
                //      case "Ti": return -2
                default: break
                }
            }

        case let .systemImage(name):
            switch name {
            case "list.bullet": return 1
            case "rectangle.connected.to.line.below": return -0.3
            default: break
            }

        default:
            break
        }

        return 0
    }
}
