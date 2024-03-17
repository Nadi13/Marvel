import UIKit

class TriangleView: UIView {
    
    var triangleColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect){
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.maxX, y: rect.maxY/3.4))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.closePath()
        context.setFillColor(triangleColor.cgColor)
        context.fillPath()
    }
}
