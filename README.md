# CCAutoScrollView
CCAutoScrollView is an carousel view written by swift

# Requirements
<ul>
<li><p>Xcode8.0+</p></li>
<li><p>Swift3.0+</p></li>
<li><p>iOS8.0+</p></li>
</ul>

# Installation
To integrate CCAutoScrollView into your Xcode project using CocoaPods, specify it in your Podfile:
	
	target '<Your Target Name>' do
    		pod 'CCAutoScrollView', '~>2.0.4'
	end
	
# Communication
<ul>
<li><p>If you found a bug, open an issue.</p></li>
<li><p>If you have a feature request, open an issue.</p></li>
<li><p>If you need help, open an issue or QQ 389936133.</p></li>
</ul>

# Usage

# Default AutoScrollView
	let scroll = CCAutoScrollView(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
	scroll.dataSource = ["1.jpg","2.jpg","3.jpg"]
	scroll.autoScrollEnable = true //or scroll.autoScrollTimeInterval = 1.5
	scroll.delegate = self
	view.addSubview(scroll)
				
# Custom AutoScrollView
	let scroll = CCAutoScrollView(frame: CGRect(x: 0, y: 64, width: 300, height: 200))
	scroll.dataSource = [UIColor.red,UIColor.blue,UIColor.green]
	scroll.autoScrollTimeInterval = 1.5
	scroll.cellNibName = "CustomCollectionViewCell"
	scroll.cellConfig = { (cell, data) in
       guard let customCell = cell as? CustomCollectionViewCell else {
           return
       }
       guard let color = data as? UIColor else {
           return
       }
       customCell.customView.backgroundColor = color
	}
	view.addSubview(scroll)
	
# XIB AutoScrollView
	@IBOutlet weak var autoScrollView: CCAutoScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        autoScrollView.dataSource = ["http://","http://","http://"]
        autoScrollView.cellClass = CustomClassCollectionViewCell.self
        autoScrollView.autoScrollTimeInterval = 2.5
        autoScrollView.cellConfig = { (cell, data) in
            guard let customCell = cell as? CustomClassCollectionViewCell else {
                return
            }
            guard let imgUrlString = data as? String else {
                return
            }
            DispatchQueue.global().async {
                let imageData = Data(contentsOf: URL(string: imgUrlString))
                DispatchQueue.main.async {
                    customCell.imageView.image = UIImage(data: imageData)
                }
            }
			//you can use Kingfisher download and cached image
        }
    }

# Tips

cellConfig应该只能修改CollectionViewCell里面的内容，如果根据滚动修改界面的数据，参考CCAutoScrollViewDelegate

