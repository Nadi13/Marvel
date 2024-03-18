import Foundation
import UIKit
import Kingfisher
class CollectionView: UICollectionView{
    
    var cells = [Cards]()
    
    let layout = CustomLayout()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let cellSpacing = (1/16)*UIScreen.main.bounds.size.height
    
    var itemW: CGFloat {
        return screenWidth * 0.65
    }
    
    var itemH: CGFloat {
        return screenHeight * 0.5
    }
    
    let triangleView: TriangleView = {
        let triangleView = TriangleView(frame: CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        triangleView.translatesAutoresizingMaskIntoConstraints = false
        triangleView.backgroundColor = .clear
        return triangleView
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView(){
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.itemSize.width = itemW
        
        backgroundView = triangleView
        
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        contentInsetAdjustmentBehavior = .never
        contentInset = UIEdgeInsets(top: 0.0, left: cellSpacing,  bottom: 0.0, right: cellSpacing)
        decelerationRate = .fast
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)

        translatesAutoresizingMaskIntoConstraints = false
        
        reloadData()
        
    }
    
    func set(cells:[Cards]){
        self.cells = cells
    }
}
