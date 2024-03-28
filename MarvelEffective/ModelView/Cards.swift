import UIKit
import Foundation

struct Cards {
    let image: URL?
    let name: String
    let description: String?
    
    static func fetchCards() ->
    [Cards]{
        let firstItem =
        Cards(image: URL(string: "https://iili.io/JMnAfIV.png"),
              name: String(localized:"deadpool"),
              description: String(localized:"descriptionDeadpool"))
        let secondItem =
        Cards(image: URL(string: "https://iili.io/JMnuyB9.png"),
              name: String(localized:"spider"),
              description: String(localized:"descriptionSpider"))
        let thirdItem =
        Cards(image: URL(string: "https://raw.githubusercontent.com/Nadi13/Marvel/feature/LAB-1/markup/MarvelEffective/Assets.xcassets/ironman.imageset/ironman.png"),
              name: String(localized:"iron"),
              description: String(localized:"descriptionIron"))
        
        return [firstItem, secondItem, thirdItem]
    }
}
