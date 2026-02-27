import UIKit

class OvalOverlayView: UIView {
    
    // MARK: - Properties
    
    var faceArea: CGRect = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var overlayColor: UIColor = UIColor(white: 0, alpha: 0.53) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var progressColor: UIColor = .systemBlue {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var recordingProgress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var borderColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var strokeWidth: CGFloat = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // Required initializer for storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    private func setup() {
        backgroundColor = .clear
        isOpaque = false
    }
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard faceArea != .zero else { return }
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Draw dimmed overlay with oval hole
        let ovalPath = UIBezierPath(ovalIn: faceArea)
        
        context.saveGState()
        
        // Create clipping path (inverse of oval)
        let fullRect = UIBezierPath(rect: bounds)
        fullRect.append(ovalPath)
        fullRect.usesEvenOddFillRule = true
        fullRect.addClip()
        
        // Fill the overlay
        overlayColor.setFill()
        context.fill(bounds)
        
        context.restoreGState()
        
        // Draw the oval border
        ovalPath.lineWidth = strokeWidth
        borderColor.setStroke()
        ovalPath.stroke()
        
        // Draw the progress arc

        // Calculate angles
        let startAngle = -CGFloat.pi / 2
        let sweepAngle = recordingProgress * 2 * CGFloat.pi

        // Save context state
        context.saveGState()

        // Scale context to make circle into oval
        let scaleX: CGFloat = 1.0
        let scaleY = faceArea.height / faceArea.width
        context.translateBy(x: faceArea.midX, y: faceArea.midY)
        context.scaleBy(x: scaleX, y: scaleY)

        // Draw arc as a circle (will be stretched to oval by transform)
        let radius = faceArea.width / 2
        let progressPath = UIBezierPath(
            arcCenter: .zero,
            radius: radius,
            startAngle: startAngle,
            endAngle: startAngle + sweepAngle,
            clockwise: true
        )

        progressPath.lineWidth = strokeWidth / scaleY + 0.5
        progressPath.lineCapStyle = .round
        progressColor.setStroke()
        progressPath.stroke()

        context.restoreGState()
    }
}
