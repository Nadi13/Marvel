import UIKit

extension UIColor {
    static func mostCommonColor(in image: UIImage) -> UIColor? {
        guard let inputImage = CIImage(image: image) else { return nil }
        
        let colorValues = NSCountedSet()
        let imageColors = inputImage.getColors()
        
        for color in imageColors {
            colorValues.add(color)
        }
        
        var maxCount = 0
        var mostCommonColor: CIColor?
        
        for color in colorValues {
            let count = colorValues.count(for: color)
            if count > maxCount {
                maxCount = count
                mostCommonColor = color as? CIColor
            }
        }
        
        if let rgbColor = mostCommonColor {
            return UIColor(ciColor: rgbColor)
        }
        
        return nil
    }
}


extension CIImage {
    func getColors() -> [CIColor] {
        if let inputImage = self as? CIImage {
            let extent = inputImage.extent
            let inputPixels = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: Int(extent.size.width * extent.size.height * 4))
            let outputContext = CIContext(options: nil)
            
            outputContext.render(inputImage, toBitmap: inputPixels.baseAddress!, rowBytes: Int(extent.size.width) * 4, bounds: extent, format: CIFormat.RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
            
            var imageColors = [CIColor]()
            
            for x in 0..<Int(extent.size.width) {
                for y in 0..<Int(extent.size.height) {
                    let offset = 4 * (y * Int(extent.size.width) + x)
                    let red = CGFloat(inputPixels[offset]) / 255.0
                    let green = CGFloat(inputPixels[offset + 1]) / 255.0
                    let blue = CGFloat(inputPixels[offset + 2]) / 255.0
                    let alpha = CGFloat(inputPixels[offset + 3]) / 255.0
                    
                    let color = CIColor(red: red, green: green, blue: blue, alpha: alpha)
                    imageColors.append(color)
                }
            }
            
            inputPixels.deallocate()
            
            return imageColors
        } else {
            return []
        }
    }
}


