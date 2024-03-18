import UIKit
import Foundation
import Kingfisher

struct Cards {
    let image: URL?
    let name: String
    
    static func fetchCards() ->
    [Cards]{
        let firstItem =
        Cards(image: URL(string: "https://raw.githubusercontent.com/Nadi13/Marvel/feature/LAB-1/markup/MarvelEffective/Assets.xcassets/deadpool.imageset/deadpool.png"),
              name: String(localized:"deadpool"))
        let secondItem =
        Cards(image: URL(string: "https://raw.githubusercontent.com/Nadi13/Marvel/feature/LAB-1/markup/MarvelEffective/Assets.xcassets/spiderman.imageset/spider.png"),
              name: String(localized:"spider"))
        let thirdItem =
        Cards(image: URL(string: "https://raw.githubusercontent.com/Nadi13/Marvel/feature/LAB-1/markup/MarvelEffective/Assets.xcassets/ironman.imageset/ironman.png"),
              name: String(localized:"iron"))
        return [firstItem, secondItem, thirdItem]
    }
    
}

