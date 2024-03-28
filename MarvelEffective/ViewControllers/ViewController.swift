import UIKit

class ViewController: UIViewController{
    
    let collectionView = CollectionView()
    
    var firstRun = true
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleToFill
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logo.heightAnchor.constraint(equalToConstant: 27),
            logo.widthAnchor.constraint(equalToConstant: 128)
        ])
        return logo
    }()
    
    private func setImage(){
        view.addSubview(logo)
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(localized:"choose")
        label.textColor = Colors.white
        label.font = Fonts.Inter_28
        return label
    }()
    
    private func setText(){
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 60),
            collectionView.heightAnchor.constraint(equalToConstant: collectionView.screenHeight*0.7),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.set(cells: Cards.fetchCards())
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.black
        
        setImage()
        setText()
        setView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstRun {
            
            firstRun = false
            
            let indexPath = IndexPath(item: 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            collectionView.layout.currentPage = indexPath.item
            
            collectionView.layout.previousOffset = collectionView.layout.updateOffset(collectionView)
            
            if let cell = collectionView.cellForItem(at:indexPath){
            transformCell(cell)
            }
        }

}
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class CustomNavigationController: UINavigationController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
