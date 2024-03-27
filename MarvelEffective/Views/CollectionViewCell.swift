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
        
        setupUI()
    }
    
    private func setupUI(){
        addSubview(mainImageView)
        addSubview(nameHeroe)
        
        NSLayoutConstraint.activate([
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        mainImageView.topAnchor.constraint(equalTo: topAnchor),
        mainImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        nameHeroe.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
        nameHeroe.trailingAnchor.constraint(equalTo: trailingAnchor),
        nameHeroe.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25.0)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
