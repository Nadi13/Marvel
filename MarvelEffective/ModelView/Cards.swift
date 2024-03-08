import UIKit
import Foundation

struct Cards {
    let image: UIImage?
    let name: String
    
    static func fetchCards() ->
    [Cards]{
        let firstItem =
        Cards(image: UIImage(named: "deadpool")!,
              name: String(localized:"deadpool"))
        let secondItem =
        Cards(image: UIImage(named: "spiderman")!,
              name: String(localized:"spider"))
        let thirdItem =
        Cards(image: UIImage(named: "ironman")!,
              name: String(localized:"iron"))
        
        return [firstItem, secondItem, thirdItem]
    }
}
