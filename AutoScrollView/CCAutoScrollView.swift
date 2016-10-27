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

protocol CCAutoScrollViewDelegate: class{
    
    /// did select at index path
    ///
    /// - parameter scrollView:
    /// - parameter indexPath:
    func autoScrollView(_ scrollView: CCAutoScrollView, didSelectItemAt indexPath: IndexPath)
    
    /// did scroll to index path
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

class CCAutoScrollView: UIView {
    
    weak var delegate: CCAutoScrollViewDelegate?
    
    public private(set) var collectionView: UICollectionView!
    
    private var flowlayout: UICollectionViewFlowLayout!
    //timer is optional,Timer is strong target to self
    private var timer: DispatchSourceTimer?
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
        timer = DispatchSource.makeTimerSource()
        timer?.scheduleRepeating(deadline: DispatchTime.now()+DispatchTimeInterval.milliseconds(Int(autoScrollTimeInterval*1000)), interval: autoScrollTimeInterval)
        timer?.setEventHandler(handler: { [weak self] in
            if let strongSelf = self {
                strongSelf.autoScrollAction()
            }
        })
        timer?.resume()
    }
    //MARK: - invalidate timer
    private func invalidateTimer() {
        timer?.cancel()
        timer = nil
    }
    //MARK: - auto scroll action
    @objc private func autoScrollAction() {
        currentIndex += 1
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .left, animated: true)
    }
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoScrollEnable {
            self.invalidateTimer()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
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
        if dataSource.count > 1 {
            let firstItem = dataSource[0]
            let lastItem = dataSource.last
            workDataSource.insert(lastItem, at: 0)
            workDataSource.append(firstItem)
            
            collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
        }
    }
    
    //MARK: - initialization
    private func initialization() {
        self.layoutIfNeeded()
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
            config(cell, workDataSource[indexPath.row])
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

extension CCAutoScrollView: UICollectionViewDelegate {
    //MARK: - UICollectionView delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.autoScrollView(self, didSelectItemAt: indexPath)
    }
    //MARK: - UIScrollView delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.position(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.position(scrollView)
    }
    
    func position(_ scrollView: UIScrollView) {
        let maxRightOffset = collectionView.bounds.size.width * CGFloat(workDataSource.count-1)
        if scrollView.contentOffset.x == maxRightOffset {
            let firstIndexPath = IndexPath(item: 1, section: 0)
            collectionView.scrollToItem(at: firstIndexPath, at: .left, animated: false)
            currentIndex = 1
        } else if (scrollView.contentOffset.x == 0) {
            let lastIndexPath = IndexPath(item: workDataSource.count-2, section: 0)
            collectionView.scrollToItem(at: lastIndexPath, at: .left, animated: false)
            currentIndex = workDataSource.count - 2
        } else {
            currentIndex = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        }
        delegate?.autoScrollView(self, scrollToItemAt: IndexPath(item: currentIndex, section: 0))
    }
}
