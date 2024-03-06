import UIKit

class ViewController: UIViewController {
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        
        setImage()
        setText()
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

