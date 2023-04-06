//
//  CircularProgressView.swift
//  Photography
//
//  Created by Alireza Sotoudeh on 4/5/23.
//

import UIKit

final class CircularProgressView: UIView {
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    fileprivate var didConfigureLabel = false
    fileprivate var lineWidth: CGFloat = 2
    var timeToFill = 0.3
    
    private var size: CGFloat = .zero
    private var halfSize: CGFloat { size/2 }
    private var centePoint: CGPoint {
        .init(x: halfSize, y: halfSize)
    }
    
    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor = UIColor.white {
        didSet{
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    var progress: Float = .zero {
        didSet{
            var pathMoved = progress - oldValue
            if pathMoved < .zero {
                pathMoved = 0 - pathMoved
            }
            setProgress(duration: timeToFill * Double(pathMoved), to: progress)
        }
    }
    
    fileprivate func createProgressView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
        layer.cornerRadius = halfSize
        let circularPath = UIBezierPath(arcCenter: centePoint, radius: halfSize, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        trackLayer.fillColor = UIColor.blue.cgColor
        
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = .none
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeEnd = 1
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = .none
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = .zero
        progressLayer.lineCap = .square
        layer.addSublayer(progressLayer)
    }
    
    func trackColorToProgressColor() -> Void{
        trackColor = progressColor
        guard let colorComponents = progressColor.cgColor.components else { return }
        trackColor = UIColor(red: colorComponents[0],
                             green: colorComponents[1],
                             blue: colorComponents[2],
                             alpha: 0.2)
    }
    
    func setProgress(duration: TimeInterval = 0.3, to newProgress: Float) -> Void{
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = newProgress
        progressLayer.strokeEnd = CGFloat(newProgress)
        progressLayer.add(animation, forKey: "animationProgress")
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // Must be implemented only programatically via the custom init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(progress: Float = .zero, size: CGFloat, lineWidth: CGFloat = 2.2) {
        super.init(frame: .zero)
        self.progress = progress
        self.size = size
        self.lineWidth = lineWidth
        createProgressView()
    }
}
