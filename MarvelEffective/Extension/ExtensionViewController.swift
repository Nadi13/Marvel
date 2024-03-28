import UIKit
import Foundation
import Kingfisher

extension ViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == self.collectionView.layout.currentPage {
                    let page = DetailsScreenController()
                    navigationController?.pushViewController(page, animated: true)
        } else {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.layout.currentPage = indexPath.item
            self.collectionView.layout.previousOffset = self.collectionView.layout.updateOffset(collectionView)
            setupCell()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: self.collectionView.itemW, height: self.collectionView.itemH)
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionView.cells.count
}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:CollectionViewCell.reuseID, for: indexPath) as! CollectionViewCell
        
        cell.mainImageView.kf.setImage(with: self.collectionView.cells[indexPath.row].image)
        cell.nameHeroe.text = self.collectionView.cells[indexPath.row].name
        
        return cell
    }
}

extension ViewController{
    
    func updateTriangleColor(elem: Cards){
        guard let img = elem.image else {return}
        KingfisherManager.shared.retrieveImage(with: img, completionHandler: {
                result in
            DispatchQueue.main.async{
                switch result{
                case .success(let value):
                    self.collectionView.triangleView.triangleColor = value.image.areaAverage!
                case .failure(_):
                    self.collectionView.triangleView.triangleColor = .red
                }
            }
        })
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupCell()
        }
    }
    
    func setupCell() {
        let indexPath = IndexPath(item: collectionView.layout.currentPage, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) {
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
        
        
        for otherCell in collectionView.visibleCells {
            if let indexPath = collectionView.indexPath(for: otherCell) {
                if indexPath.item != collectionView.layout.currentPage {
                    UIView.animate(withDuration: 0.2) {
                        otherCell.transform = .identity
                    }
                }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexPath = IndexPath(item: collectionView.layout.currentPage, section: 0)
        let card = collectionView.cells[indexPath.row]
        updateTriangleColor(elem: card)
    }
}
