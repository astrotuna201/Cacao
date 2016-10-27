//
//  NSStringDrawing.swift
//  Cacao
//
//  Created by Alsey Coleman Miller on 5/30/16.
//  Copyright © 2016 PureSwift. All rights reserved.
//

import Silica
import Foundation
//#if os(Linux)

/// Expects `UIFont` value.
public let NSFontAttributeName = "NSFont"

/// Expects `UIColor` value.
public let NSForegroundColorAttributeName = "NSForegroundColor"

/// Expects `NSMutableParagraphStyle` value.
public let NSParagraphStyleAttributeName = "NSParagraphStyle"

//#endif

public extension String {
	
    /// UIKit compatility drawing
    func draw(in rect: Rect, withAttributes attributes: [String: Any]) {
        
        guard let context = UIGraphicsGetCurrentContext()?.silicaContext
            else { return }
        
        // get values from attributes
        let textAttributes = TextAttributes(UIKit: attributes)
        
        self.draw(in: rect, context: context, attributes: textAttributes)
    }
    
    func boundingRect(with size: Size, options: NSStringDrawingOptions = NSStringDrawingOptions(), attributes: [String: Any], context: NSStringDrawingContext? = nil) -> Rect {
        
        guard let context = UIGraphicsGetCurrentContext()?.silicaContext
            else { return Rect() }
        
        let textAttributes = TextAttributes(UIKit: attributes)
        
        var textFrame = self.contentFrame(for: Rect(size: size), textMatrix: context.textMatrix, attributes: textAttributes)
        
        let font = textAttributes.font
        
        let descender = (Double(font.silicaFont.scaledFont.descent) * font.size) / Double(font.silicaFont.scaledFont.unitsPerEm)
        
        textFrame.height -= descender
        
        return textFrame
    }
}

// MARK: - Supporting Types

public typealias NSParagraphStyle = NSMutableParagraphStyle
public typealias NSStringDrawingContext = Void


public extension TextAttributes {
    
    init(UIKit attributes: [String: Any]) {
        
        var textAttributes = TextAttributes()
        
        if let font = attributes[Cacao.NSFontAttributeName] as? UIFont {
            
            textAttributes.font = font
        }
        
        if let textColor = (attributes[Cacao.NSForegroundColorAttributeName] as? UIColor)?.CGColor {
            
            textAttributes.color = textColor
        }
        
        if let paragraphStyle = attributes[Cacao.NSParagraphStyleAttributeName] as? NSParagraphStyle {
            
            textAttributes.paragraphStyle = paragraphStyle.toCacao()
        }
        
        self = textAttributes
    }
}

/// Encapsulates the paragraph or ruler attributes.
public final class NSMutableParagraphStyle {
    
    // MARK: - Properties
    
    /// The text alignment
    public var alignment = NSTextAlignment()
    
    // MARK: - Initialization
    
    public init() { }
    
    public static func `default`() -> NSMutableParagraphStyle {
        
        return NSMutableParagraphStyle()
    }
}

extension NSMutableParagraphStyle: CacaoConvertible {
    
    public func toCacao() -> ParagraphStyle {
        
        var paragraphStyle = ParagraphStyle()
        
        paragraphStyle.alignment = alignment.toCacao()
        
        return paragraphStyle
    }
}

public enum NSTextAlignment: Int {
    
    case left
    case center
    case right
    case justified
    case natural
    
    public init() { self = .left }
}

extension NSTextAlignment: CacaoConvertible {
    
    public func toCacao() -> TextAlignment {
        
        switch self {
            
        case .left: return .left
        case .center: return .center
        case .right: return .right
            
        default: return .left
        }
    }
}

public enum NSLineBreakMode: Int {
    
    /// Wrap at word boundaries, default
    case byWordWrapping = 0
    case byCharWrapping
    case byClipping
    case byTruncatingHead
    case byTruncatingTail
    case byTruncatingMiddle
    
    public init() { self = .byWordWrapping }
}

/*
extension NSLineBreakMode: CacaoConvertible {
    
    
}*/

/// Rendering options for a string when it is drawn.
public struct NSStringDrawingOptions: OptionSet, ExpressibleByIntegerLiteral {
    
    public static let usesLineFragmentOrigin = NSStringDrawingOptions(rawValue: (1 << 0))
    public static let usesFontLeading = NSStringDrawingOptions(rawValue: (1 << 1))
    public static let usesDeviceMetrics = NSStringDrawingOptions(rawValue: (1 << 3))
    public static let truncatesLastVisibleLine = NSStringDrawingOptions(rawValue: (1 << 5))
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        
        self.rawValue = rawValue
    }
    
    public init(integerLiteral value: Int) {
        
        self.rawValue = value
    }
    
    public init() {
        
        self = NSStringDrawingOptions.usesLineFragmentOrigin
    }
}



#if NeverCompile
    
    /// For source code compatiblity, without Foundation.
    ///
    /// - Note: You can later specify if you want `Cacao.NSString` or `Foundation.NSString` using typealiases.
    @inline(__always)
    public func NSString(string: String) -> String {
        
        return string
    }
    
#endif
