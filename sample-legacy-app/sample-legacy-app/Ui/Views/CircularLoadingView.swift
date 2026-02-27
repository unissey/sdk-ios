import UIKit

class CircularLoadingView: UIView {
    
    private let progressLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 3
        progressLayer.lineCap = .round
        progressLayer.lineJoin = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0.7
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - 3) / 2
        
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: 3 * CGFloat.pi / 2,
            clockwise: true
        )
        
        progressLayer.path = circularPath.cgPath
    }
    
    func startAnimating() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * CGFloat.pi
        rotation.duration = 1
        rotation.repeatCount = .infinity
        layer.add(rotation, forKey: "rotation")
    }
    
    func stopAnimating() {
        progressLayer.removeAllAnimations()
    }
}
