import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CollectionViewCell"
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = .none
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let nameHeroe: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = Colors.white
        name.font = Fonts.Inter_32
        return name
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addSubview(mainImageView)
        addSubview(nameHeroe)
        
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        nameHeroe.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        nameHeroe.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameHeroe.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
