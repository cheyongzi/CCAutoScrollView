//
//  CCAutoScrollView.swift
//
//  Created by Che Yongzi on 2016/10/24.
//  Copyright © 2016年 Che Yongzi. All rights reserved.
//

/*
 * 在您使用的过程中如果出现bug请联系我，我会及时修复bug并
 * 帮您解决问题
 * GitHub: https://github.com/cheyongzi/
 * QQ      389936133
 */

import UIKit

///  seperate code
///
/// - parameter method: 执行的block
func closure(method: () -> ()) {
    method()
}

public protocol CCAutoScrollViewDelegate: class{
    
    /// did select at index path
    ///
    /// - parameter scrollView:
    /// - parameter indexPath:
    func autoScrollView(_ scrollView: CCAutoScrollView, didSelectItemAt indexPath: IndexPath)
    
    
    /// scroll to index path
    ///
    /// - parameter scrollView:
    /// - parameter indexPath:
    func autoScrollView(_ scrollView: CCAutoScrollView, scrollToItemAt indexPath: IndexPath)
}

extension CCAutoScrollViewDelegate {
    func autoScrollView(_ scrollView: CCAutoScrollView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func autoScrollView(_ scrollView: CCAutoScrollView, scrollToItemAt indexPath: IndexPath) {
        
    }
}

let identifier: String = "CCAutoScrollViewCell"

open class CCAutoScrollView: UIView {
    
    weak var delegate: CCAutoScrollViewDelegate?
    
    public private(set) var collectionView: UICollectionView!
    
    private var flowlayout: UICollectionViewFlowLayout!
    //timer is optional
    private var timer: Timer?
    //current index default is 1
    var currentIndex: Int = 1
    //MARK: - auto scroll time default is 5.0
    var autoScrollTimeInterval: Double = 5.0 {
        didSet {
            if autoScrollTimeInterval > 0 {
                self.autoScrollEnable = true
            } else {
                self.autoScrollEnable = false
            }
            
        }
    }
    //MARK: - autoscroll enable
    var autoScrollEnable: Bool = true {
        didSet {
            if !autoScrollEnable {
                self.invalidateTimer()
            } else {
                self.setupTimer()
            }
        }
    }
    
    //MARK: - Set up timer
    private func setupTimer() {
        guard workDataSource.count > 0 else {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: autoScrollTimeInterval, target: self, selector: #selector(autoScrollAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
    }
    //MARK: - invalidate timer
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    //MARK: - auto scroll action
    @objc private func autoScrollAction() {
        currentIndex += 1
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoScrollEnable {
            self.invalidateTimer()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if autoScrollEnable {
            self.setupTimer()
        }
    }
    //MARK: - register cell class custom cell user code
    var cellClass: AnyClass? {
        didSet {
            collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
    //MARK: - register cell nib custom cell use xib
    var cellNibName: String? {
        didSet {
            if let nibName = cellNibName {
                collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: identifier)
            }
        }
    }
    //MARK: - cell config
    var cellConfig: ((UICollectionViewCell, Any) -> ())?
    
    //MARK: - data source
    var dataSource: [Any] = [] {
        didSet {
            self.setupDatas()
        }
    }
    //MARK: - setup datas
    public private(set) var workDataSource: [Any] = []
    private func setupDatas() {
        workDataSource = dataSource
        guard dataSource.count > 0 else {
            return
        }
        
        let firstItem = dataSource[0]
        let lastItem = dataSource.last
        workDataSource.insert(lastItem!, at: 0)
        workDataSource.append(firstItem)
        
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    //MARK: - initialization
    private func initialization() {
        
        closure {
            flowlayout = UICollectionViewFlowLayout()
            flowlayout.minimumLineSpacing = 0
            flowlayout.minimumInteritemSpacing = 0
            flowlayout.itemSize = self.bounds.size
            flowlayout.scrollDirection = .horizontal
        }
        
        closure {
            collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowlayout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.scrollsToTop = false
            collectionView.register(CCCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
            collectionView.isPagingEnabled = true
            self.addSubview(collectionView)
            
            let topConstraint = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            let botConstraint = NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            let leftConstraint = NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
            let rightConstraint = NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([topConstraint, botConstraint, leftConstraint, rightConstraint])
        }
    }
    
    //MARK: - Init method
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        flowlayout.itemSize = self.bounds.size
        collectionView.frame = self.bounds
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            self.invalidateTimer()
        }
    }
    
    //MARK: - Deinit
    deinit {
        print("CCAutoScrollView deinit")
    }

}

extension CCAutoScrollView: UICollectionViewDataSource{
    //MARK: - UICollectionView data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        if let config = cellConfig {
            config(cell, workDataSource[indexPath.item])
        } else {
            if let defaultCell = cell as? CCCollectionViewCell {
                if let imageName = workDataSource[indexPath.row] as? String {
                    defaultCell.imageView.image = UIImage(named: imageName)
                }
            }
        }
        return cell
    }
}

extension CCAutoScrollView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //MARK: - UICollectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.autoScrollView(self, didSelectItemAt: IndexPath(item: currentCellIndex()-1, section: 0))
    }
    
    //MARK: - UIScrollView delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.position(scrollView)
        delegate?.autoScrollView(self, scrollToItemAt: IndexPath(item: currentCellIndex()-1, section: 0))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func position(_ scrollView: UIScrollView) {
        let maxRightOffset = collectionView.bounds.size.width * CGFloat(workDataSource.count-1)
        if scrollView.contentOffset.x >= maxRightOffset {
            let firstIndexPath = IndexPath(item: 1, section: 0)
            collectionView.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: false)
        } else if (scrollView.contentOffset.x <= 0) {
            let lastIndexPath = IndexPath(item: workDataSource.count-2, section: 0)
            collectionView.scrollToItem(at: lastIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
    
    func currentCellIndex() -> Int {
        let index = Int(collectionView.contentOffset.x / collectionView.bounds.size.width)
        currentIndex = index
        if currentIndex == workDataSource.count - 1 {
            currentIndex = 1
        } else if currentIndex == 0 {
            currentIndex = workDataSource.count - 2
        }
        return currentIndex
    }
}
