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
    
    var progress: Float {
        didSet{
            var pathMoved = progress - oldValue
            if pathMoved < .zero {
                pathMoved = 0 - pathMoved
            }
            setProgress(duration: timeToFill * Double(pathMoved), to: progress)
        }
    }
 
    fileprivate func createProgressView() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = frame.size.width / 2
        let circularPath = UIBezierPath(arcCenter: center, radius: frame.width / 2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
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
        progressLayer.strokeEnd = 0
        progressLayer.lineCap = .square //cc
        layer.addSublayer(progressLayer)
    }
    
    func trackColorToProgressColor() -> Void{
        trackColor = progressColor
        guard let colorComponents = progressColor.cgColor.components else { return }
        trackColor = UIColor(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2], alpha: 0.2)
    }
    
    func setProgress(duration: TimeInterval = 0.3, to newProgress: Float) -> Void{
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = newProgress
        progressLayer.strokeEnd = CGFloat(newProgress)
        progressLayer.add(animation, forKey: "animationProgress")
    }
    
    override init(frame: CGRect){
        progress = .zero
        lineWidth = 2
        super.init(frame: frame)
        createProgressView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, lineWidth: CGFloat) {
        progress = .zero
        self.lineWidth = lineWidth
        super.init(frame: frame)
        createProgressView()
    }
}
