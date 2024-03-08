import UIKit

class TriangleView: UIView {
    
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
        context.move(to: CGPoint(x: rect.maxX, y: rect.maxY/2.3))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.closePath()
        context.setFillColor(red:139.0, green: 0.0, blue: 0.0, alpha: 1.0)
        context.fillPath()
    }
}
