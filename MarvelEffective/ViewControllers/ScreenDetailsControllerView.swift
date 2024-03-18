import Foundation
import UIKit
import Kingfisher

class ScreenDetailsControllerView: UIViewController{
    
    var selectedCell: Int?
    
    let collectionView = CollectionView()
    
    private func setView() {
        view.addSubview(collectionView)
        collectionView.set(cells: Cards.fetchCards())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        setView()
        setBackgroundImageView()
        setName()
        setDescriptionHeroe()
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return backgroundImageView
    }()
    
    private func setBackgroundImageView(){
        view.insertSubview(backgroundImageView, at: 0)
        
        
        let imageUrl = self.collectionView.cells[selectedCell!].image
        backgroundImageView.kf.setImage(with: imageUrl)
        
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private lazy var name: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = self.collectionView.cells[selectedCell!].name
        name.textColor = Colors.white
        name.font = Fonts.Inter_34
        return name
    }()
    
    private func setName(){
        view.addSubview(name)
        
        NSLayoutConstraint.activate([
            name.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private lazy var descriptionHeroe: UILabel = {
        let descriptionHeroe = UILabel()
        descriptionHeroe.translatesAutoresizingMaskIntoConstraints = false
        descriptionHeroe.text = self.collectionView.cells[selectedCell!].description
        descriptionHeroe.textColor = Colors.white
        descriptionHeroe.font = Fonts.Inter_22
        descriptionHeroe.numberOfLines = 0
        descriptionHeroe.lineBreakMode = .byWordWrapping
        return descriptionHeroe
    }()
    
    private func setDescriptionHeroe(){
        view.addSubview(descriptionHeroe)
        
        NSLayoutConstraint.activate([
            descriptionHeroe.widthAnchor.constraint(equalToConstant: 320),
            descriptionHeroe.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 12),
            descriptionHeroe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
}
