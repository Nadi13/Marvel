import UIKit



class ViewController: UIViewController {
    
    var cells = [Cards]()
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let cellSpacing = 50.0
    
    
    private let layout = CustomLayout()
    
    var itemW: CGFloat {
        return screenWidth * 0.65
    }
    
    var itemH: CGFloat {
        return screenHeight * 0.5
    }
    
    private let collectionView = UICollectionView(frame:.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        layout.currentPage = indexPath.item
        layout.previousOffset = layout.updateOffset(collectionView)
        
        if let cell = collectionView.cellForItem(at:indexPath){
            transformCell(cell)
        }
    }
    
    private func createLabel (font: UIFont, text: String) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = Colors.white
        label.font = font
        
        return label
    }
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleToFill
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.heightAnchor.constraint(equalToConstant: 27).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 128).isActive = true
        return logo
    }()
    
    private func setImage(){
        view.addSubview(logo)
        logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setText(){
        let title: UILabel = createLabel(font: Fonts.Inter_28!, text: String(localized:"choose"))  
        view.addSubview(title)
        NSLayoutConstraint.activate([
        title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 54),
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func set(cells:[Cards]){
        self.cells = cells
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        
        setImage()
        setText()
        setupViews()
        
        set(cells:Cards.fetchCards())
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController {
    private func setupViews() {
        collectionView.backgroundColor = .none
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: cellSpacing,  bottom: 0.0, right: cellSpacing)
        collectionView.decelerationRate = .fast
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.itemSize.width = itemW
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            collectionView.heightAnchor.constraint(equalToConstant: screenHeight*0.7)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
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

extension ViewController: UICollectionViewDelegate {
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

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: itemW, height: itemH)
    }
}

extension ViewController{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupCell()
        }
    }
    
    private func setupCell(){
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath){
            transformCell(cell)
        }
    }
    
    private func transformCell(_ cell: UICollectionViewCell, isEffect: Bool = true){
        if !isEffect {
            cell.transform = CGAffineTransform(scaleX: 1.2, y:1.2)
            return
        }
        
        UIView.animate(withDuration: 0.2){
            cell.transform = CGAffineTransform(scaleX: 1.2, y:1.2)
        }
        
        for otherCell in collectionView.visibleCells {
            if let indexPath = collectionView.indexPath(for: otherCell){
                if indexPath.item != layout.currentPage{
                    UIView.animate(withDuration: 0.2){
                        otherCell.transform = .identity
                    }
                }
            }
        }
    }
}
