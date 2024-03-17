import UIKit
import Foundation

extension CollectionView: UICollectionViewDelegate{
    
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

extension CollectionView: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCell.reuseID, for: indexPath) as! CollectionViewCell
        cell.mainImageView.image = cells[indexPath.row].image
        cell.nameHeroe.text = cells[indexPath.row].name
        return cell
    }
}

extension CollectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: itemW, height: itemH)
    }
}
