import UIKit
import Foundation
import Kingfisher

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
        
        if let imageURL = self.cells[indexPath.row].image {
                cell.mainImageView.kf.setImage(with: imageURL) { result in
                    switch result {
                        case .success(_):
                            cell.setNeedsLayout()
                        case .failure(let error):
                            print("Error loading image: \(error.localizedDescription)")
                    }
                }
            }

        cell.nameHeroe.text = cells[indexPath.row].name
        return cell
    }
}

extension CollectionView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: itemW, height: itemH)
    }
}
