//
//  UIBezierPath.swift
//  Cacao
//
//  Created by Alsey Coleman Miller on 5/12/16.
//  Copyright © 2016 PureSwift. All rights reserved.
//

import Silica

/// The `UIBezierPath` class lets you define a path consisting of straight and curved line segments
/// and render that path in your custom views. You use this class initially to specify just the geometry for your path. 
/// Paths can define simple shapes such as rectangles, ovals, and arcs or they can define complex polygons that 
/// incorporate a mixture of straight and curved line segments. 
/// After defining the shape, you can use additional methods of this class to render the path in the current drawing context.
///
/// A `UIBezierPath` object combines the geometry of a path with attributes that describe the path during rendering.
/// You set the geometry and attributes separately and can change them independent of one another. 
/// Once you have the object configured the way you want it, you can tell it to draw itself in the current context. 
/// Because the creation, configuration, and rendering process are all distinct steps,
/// Bezier path objects can be reused easily in your code. 
/// You can even use the same object to render the same shape multiple times, 
/// perhaps changing the rendering options between successive drawing calls.
public final class UIBezierPath {
    
    // MARK: - Properties
    
    public var CGPath: Path
    
    public var lineWidth: Double = 1.0
    
    public var lineCapStyle: LineCap = .butt
    
    public var lineJoinStyle: LineJoin = .miter
    
    public var miterLimit: Double = 10
    
    public var flatness: Double = 0.6
    
    public var usesEvenOddFillRule: Bool = false
    
    public var lineDash: (phase: Double, lengths: [Double]) = (0.0, [])
    
    // MARK: - Initialization
    
    public init(CGPath path: Path = Path()) {
        
        self.CGPath = path
    }
    
    public init(rect: Rect) {
        
        var path = Path()
        
        path.addRect(rect)
        
        self.CGPath = path
    }
    
    public init(ovalIn rect: Rect) {
        
        var path = Path()
        
        path.addEllipse(in: rect)
        
        self.CGPath = path
    }
    
    // MARK: - Accessors
    
    public var currentPoint: Point {
        
        fatalError("Not implemented")
    }
    
    public var isEmpty: Bool {
        
        return CGPath.elements.isEmpty
    }
    
    public var bounds: Rect {
        
        fatalError("Not implemented")
    }
    
    // MARK: - Methods
    
    // MARK: Drawing
    
    public func fill() {
        
        guard let context = UIGraphicsGetCurrentContext()?.silicaContext
            else { return }
        
        try! context.save()
        
        setContextPath()
        
        try! context.fill(evenOdd: usesEvenOddFillRule)
        context.beginPath()
        try! context.restore()
    }
    
    // MARK: Clipping Paths
    
    public func addClip() {
        
        guard let context = UIGraphicsGetCurrentContext()?.silicaContext
            else { return }
        
        setContextPath()
        
        context.clip(usesEvenOddFillRule)
    }
    
    // MARK: - Constructing a Path
    
    public func move(to point: Point) {
        
        CGPath.elements.append(.moveToPoint(point))
    }
    
    public func addLine(to point: Point) {
        
        CGPath.elements.append(.addLineToPoint(point))
    }
    
    public func addCurve(to endPoint: Point, controlPoint1: Point, controlPoint2: Point) {
        
        CGPath.elements.append(.addCurveToPoint(controlPoint1, controlPoint2, endPoint))
    }
    
    public func addQuadCurve(to endPoint: Point, controlPoint: Point) {
        
        CGPath.elements.append(.addQuadCurveToPoint(controlPoint, endPoint))
    }
    
    public func close() {
        
        CGPath.elements.append(.closeSubpath)
    }
    
    public func addArc(with center: Point, radius: Double, startAngle: Double, endAngle: Double, clockwise: Bool) {
        
        fatalError("Not implemented")
    }
    
    // MARK: - Private Methods
    
    fileprivate func setContextPath() {
        
        guard let context = UIGraphicsGetCurrentContext()?.silicaContext
            else { return }
        
        context.beginPath()
        context.add(CGPath)
        context.lineWidth = lineWidth
        context.lineCap = lineCapStyle
        context.lineJoin = lineJoinStyle
        context.miterLimit = miterLimit
        context.tolerance = flatness
        context.lineDash = lineDash
    }
}
