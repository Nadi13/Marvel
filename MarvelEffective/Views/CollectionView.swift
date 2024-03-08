import Foundation
import UIKit



class CollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cells = [Cards]()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let cellSpacing = 50.0
    
    var itemW: CGFloat {
        return screenWidth * 0.65
    }
    
    var itemH: CGFloat {
        return screenHeight * 0.5
    }
    
    let layout = CustomLayout()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.itemSize.width = itemW
        
        backgroundColor = .none
        contentInsetAdjustmentBehavior = .never
        showsHorizontalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0.0, left: cellSpacing,  bottom: 0.0, right: cellSpacing)
        decelerationRate = .fast
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(cells:[Cards]){
        self.cells = cells
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCell.reuseID, for: indexPath) as! CollectionViewCell
        cell.mainImageView.image = cells[indexPath.row].image
        cell.nameHeroe.text = cells[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: itemW, height: itemH)
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
        // Ваша реализация функции transformCell здесь как метод класса
        if !isEffect {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        
        UIView.animate(withDuration: 0.2) {
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == layout.currentPage {
        } else {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            layout.currentPage = indexPath.item
            layout.previousOffset = layout.updateOffset(collectionView)
            setupCell()
        }
    }
}
