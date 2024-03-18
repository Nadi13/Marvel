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
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        
        reloadData()
        
    }
    
    func set(cells:[Cards]){
        self.cells = cells
    }
    
    func updateTriangleColor (elem: Cards) {
        guard let img = elem.image else {return}
        
        DispatchQueue.main.async{
            
            KingfisherManager.shared.retrieveImage(with: img, completionHandler: {
                result in
                switch result{
                case .success(let value):
                    self.triangleView.triangleColor = value.image.areaAverage!
                case .failure(_):
                    self.triangleView.triangleColor = .red
                }
            })
        }
    }

    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupCell()
        }
    }
    
    func setupCell() {
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = cellForItem(at: indexPath) {
        transformCell(cell)
        }
    }
    
    func transformCell(_ cell: UICollectionViewCell, isEffect: Bool = true) {
        if !isEffect {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        
        UIView.animate(withDuration: 0.2){
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        
        for otherCell in visibleCells {
            if let indexPath = indexPath(for: otherCell) {
                if indexPath.item != layout.currentPage {
                    UIView.animate(withDuration: 0.2) {
                        otherCell.transform = .identity
                    }
                }
            }
        }
    }
    

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        let card = cells[indexPath.row]
        
        updateTriangleColor(elem: card)
    }
}
