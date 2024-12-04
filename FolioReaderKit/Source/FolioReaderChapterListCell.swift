import UIKit

class FolioReaderChapterListCell: UITableViewCell {
	var indexLabel: UILabel?
	var arrowImageView: UIImageView?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
			// Initialize the label and image view
		self.indexLabel = UILabel()
		self.arrowImageView = UIImageView()
		
		guard let indexLabel = self.indexLabel, let arrowImageView = self.arrowImageView else { return }
		
			// Configure the label
		indexLabel.lineBreakMode = .byWordWrapping
		indexLabel.numberOfLines = 0
		indexLabel.font = UIFont(name: "Avenir-Light", size: 17)
		
			// Configure the arrow image view
		arrowImageView.contentMode = .scaleAspectFit
		if #available(iOS 13.0, *) {
			arrowImageView.image = UIImage(systemName: "chevron.right") // System arrow icon for iOS 13+
		} else {
			arrowImageView.image = UIImage(named: "chevron_right") // Provide a fallback image for earlier versions
		}// System arrow icon
		arrowImageView.tintColor = .gray
		
			// Create a stack view
		let stackView = UIStackView(arrangedSubviews: [indexLabel, arrowImageView])
		stackView.axis = .horizontal
		stackView.spacing = 10
		stackView.alignment = .center
		stackView.distribution = .fill
		
			// Add the stack view to the content view
		stackView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(stackView)
		
			// Set up constraints for the stack view
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			
			// Arrow image size constraints
			arrowImageView.widthAnchor.constraint(equalToConstant: 20),
			arrowImageView.heightAnchor.constraint(equalToConstant: 20)
		])
	}
	
	func setup(withConfiguration readerConfig: FolioReaderConfig) {
			// Set text color based on the configuration
		self.indexLabel?.textColor = readerConfig.menuTextColor
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("storyboards are incompatible with truth and beauty")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.indexLabel?.text = nil // Reset the label text
	}
}
