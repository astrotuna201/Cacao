//
//  UIView.swift
//  Cacao
//
//  Created by Alsey Coleman Miller on 5/27/16.
//  Copyright © 2016 PureSwift. All rights reserved.
//

import Silica

open class UIView: Drawable {
    
    // MARK: - Properties
    
    public final var frame: Rect
    
    public final var bounds: Rect { return Rect(size: frame.size) }
    
    public final var backgroundColor: UIColor = UIColor(cgColor: Color.white)
    
    public final var alpha: Double = 1.0
    
    public final var hidden: Bool = false
    
    public final fileprivate(set) var subviews: [View] = []
    
    public final var tag: Int = 0
    
    // MARK: - Initialization
    
    public init(frame: Rect = Rect()) {
        
        self.frame = frame
    }
    
    // MARK: - Subclassable Methods
    
    open func draw(_ rect: CGRect) { /* implemented by subclasses */ }
    
    // MARK: - Final Methods
    
    public final func addSubview(_ view: View) {
        
        subviews.append(view)
    }
    
    // MARK: - Drawable
    
    public final func draw(_ context: Context) {
        
        guard hidden == false && alpha > 0
            else { return }
        
        UIGraphicsPushContext(CGContext(context))
        
        // draw background color
        context.fillColor = backgroundColor.CGColor
        context.add(bounds)
        try! context.fill()
        
        // draw rect
        draw(bounds)
        
        UIGraphicsPopContext()
    }
    
    // MARK: - InteractiveView
    
    public final func handle(_ event: PointerEvent) {
        
        // translate to UIKit APIs
    }
}
