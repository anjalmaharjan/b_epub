import UIKit

class PageViewController: UIPageViewController {
	
	var tabBar: UITabBar!
	var viewList = [UIViewController]()
	var tabBarItems = [UITabBarItem]()
	var viewControllerOne: UIViewController!
	var viewControllerTwo: UIViewController!
	var index: Int
	fileprivate var readerConfig: FolioReaderConfig
	fileprivate var folioReader: FolioReader
	
		// MARK: Init
	
	init(folioReader: FolioReader, readerConfig: FolioReaderConfig) {
		self.folioReader = folioReader
		self.readerConfig = readerConfig
		self.index = self.folioReader.currentMenuIndex
		super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
		
		self.edgesForExtendedLayout = UIRectEdge()
		self.extendedLayoutIncludesOpaqueBars = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("storyboards are incompatible with truth and beauty")
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
			// Initialize tab bar
		tabBar = UITabBar()
		tabBar.frame = CGRect(x: 0, y: -28, width: self.view.frame.width, height: 0) // Reduced height
		tabBar.delegate = self
		
			// Set tab bar background color to white
		tabBar.barTintColor = UIColor.white
		tabBar.isTranslucent = false
		
			// Set tab bar items
		tabBar.items = tabBarItems
		tabBar.selectedItem = tabBarItems[index]
		
			// Adjust font size, color, and boldness for tab items
		let normalAttributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.gray, // Normal text color
			.font: UIFont.systemFont(ofSize: 16) // Normal font size
		]
		let selectedAttributes: [NSAttributedString.Key: Any] = [
			.foregroundColor: UIColor.black, // Selected text color
			.font: UIFont.boldSystemFont(ofSize: 16) // Bold font for selected item
		]
		
		UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
		UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
		
		self.view.addSubview(tabBar)
		
			// Set up view controllers
		viewList = [viewControllerOne, viewControllerTwo]
		viewControllerOne.didMove(toParent: self)
		viewControllerTwo.didMove(toParent: self)
		
		self.delegate = self
		self.dataSource = self
		
		self.view.backgroundColor = UIColor.white
		self.setViewControllers([viewList[index]], direction: .forward, animated: false, completion: nil)
		
			// Disable scroll bounce
		for view in self.view.subviews {
			if view is UIScrollView {
				let scroll = view as! UIScrollView
				scroll.bounces = false
			}
		}
		
		self.setCloseButton(withConfiguration: self.readerConfig)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureNavBar()
	}
	
	func configureNavBar() {
		let navBackground = self.folioReader.isNight(self.readerConfig.nightModeMenuBackground, self.readerConfig.daysModeNavBackground)
		let tintColor = self.readerConfig.tintColor
		let navText = self.folioReader.isNight(UIColor.white, UIColor.white)
		let font = UIFont(name: "Avenir-Light", size: 24)!
		setTranslucentNavigation(false, color: navBackground, tintColor: tintColor, titleColor: navText, andFont: font)
	}
	
		// MARK: - Tab Bar Changes
	
	func switchToViewController(at index: Int) {
		self.index = index
		let direction: UIPageViewController.NavigationDirection = (index == 0 ? .reverse : .forward)
		setViewControllers([viewList[index]], direction: direction, animated: true, completion: nil)
		self.folioReader.currentMenuIndex = index
	}
	
		// MARK: - Status Bar
	
	override var preferredStatusBarStyle : UIStatusBarStyle {
		return self.folioReader.isNight(.lightContent, .default)
	}
}

	// MARK: UITabBarDelegate

extension PageViewController: UITabBarDelegate {
	
	func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
			// Switch to the selected view controller based on the tab bar item
		switchToViewController(at: item.tag)
	}
}

	// MARK: UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		
		if finished && completed {
			let viewController = pageViewController.viewControllers?.last
			tabBar.selectedItem = tabBarItems[viewList.index(of: viewController!)!]
		}
	}
}

	// MARK: UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		
		let index = viewList.index(of: viewController)!
		if index == viewList.count - 1 {
			return nil
		}
		
		self.index = self.index + 1
		return viewList[self.index]
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		
		let index = viewList.index(of: viewController)!
		if index == 0 {
			return nil
		}
		
		self.index = self.index - 1
		return viewList[self.index]
	}
}
