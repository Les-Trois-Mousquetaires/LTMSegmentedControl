//
//  ViewController.swift
//  LTMSegmentedControl
//
//  Created by 柯南 on 2020/5/18.
//  Copyright © 2020 LTM. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,UIScrollViewAccessibilityDelegate {
    var segment = LTMSegmentedControl()
    var contenView = UIScrollView()
    var segmentItem: [String] = ["1","2","3", "4", "5"]

    var isScroll = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        segment = LTMSegmentedControl.init(items: segmentItem)
        segment.frame = CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 50)
        segment.backgroundColor = .black
        segment.addTarget(self
            , action: #selector(segmentChange), for: .valueChanged)
        self.view.addSubview(segment)
        self.underLine.frame = CGRect.init(x: self.view.frame.size.width/CGFloat((segmentItem.count * 2)) - 8.5, y: 43, width: 17, height: 7)
        segment.addSubview(self.underLine)
        
        self.configContent()
        
    }
    
    func configContent(){
        let segContentVC1 = UIViewController()
         segContentVC1.view.backgroundColor = .lightGray
         segContentVC1.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 400)
         let segContentVC2 = UIViewController()
         segContentVC2.view.backgroundColor = .yellow
         segContentVC2.view.frame = CGRect.init(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: 400)

         let segContentVC3 = UIViewController()
         segContentVC3.view.backgroundColor = .brown
         segContentVC3.view.frame = CGRect.init(x: self.view.frame.size.width * 2, y: 0, width: self.view.frame.size.width, height: 400)

         let segContentVC4 = UIViewController()
         segContentVC4.view.backgroundColor = .purple
         segContentVC4.view.frame = CGRect.init(x: self.view.frame.size.width * 3, y: 0, width: self.view.frame.size.width, height: 400)

         let segContentVC5 = UIViewController()
         segContentVC5.view.backgroundColor = .blue
         segContentVC5.view.frame = CGRect.init(x: self.view.frame.size.width * 4, y: 0, width: self.view.frame.size.width, height: 400)

         contenView.delegate = self
         contenView.backgroundColor = .orange
         contenView.frame = CGRect.init(x: 0, y: 150, width: self.view.frame.size.width, height: 400)
         contenView.contentSize = CGSize.init(width: self.view.frame.size.width * 5, height: 400)
        
         contenView.addSubview(segContentVC1.view)
         contenView.addSubview(segContentVC2.view)
         contenView.addSubview(segContentVC3.view)
         contenView.addSubview(segContentVC4.view)
         contenView.addSubview(segContentVC5.view)

         self.view.addSubview(contenView)
         contenView.isDirectionalLockEnabled = true
         contenView.isPagingEnabled = true
         contenView.showsHorizontalScrollIndicator = false
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollToScrollStop: Bool = !scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating
        if scrollToScrollStop{
            self.scrollViewStop(scrollView)
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            let dragToDragStop = scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating;
            if (dragToDragStop) {
                self.scrollViewStop(scrollView);
            }
        }
    }
    
    func scrollViewStop(_ scrollView: UIScrollView){
        let location = scrollView.contentOffset.x/self.view.frame.size.width
        var index = 0
        if (location < 0.5 ) {
               index = 0;
           } else if (location >= 0.5 && location <= 1) {
               index = 1;
           } else if (location > 1 && location <= 1.5) {
               index = 1;
           } else if (location > 1.5 && location <= 2) {
               index = 2;
           } else if (location > 2 && location <= 2.5) {
               index = 2;
           } else if (location > 2.5 && location <= 3) {
               index = 3;
           } else if (location > 3 && location <= 3.5) {
               index = 3;
           }else if (location > 3.5 && location <= 4) {
               index = 4;
           } else if (location > 4 && location <= 4.5) {
               index = 4;
           }
        isScroll = true
        self.changeUnderLineOrigin(index: index, scroll: true)
    }
    @objc func segmentChange(){
        isScroll = false
        contenView.setContentOffset(CGPoint.init(x: Int(self.view.frame.size.width) * segment.selectedSegmentIndex, y: 0), animated: true)
        self.changeUnderLineOrigin(index: segment.selectedSegmentIndex, scroll: true)
    }
    
    func changeUnderLineOrigin(index: Int, scroll: Bool){
        if isScroll == true{
            segment.selectedSegmentIndex = index
        }
        
        self.underLine.frame.origin.x = CGFloat(index) * self.view.frame.size.width/5 + self.view.frame.size.width/10 - 8.5
    }
    
    lazy var underLine: UIImageView = {
        let label = UIImageView()
        label.image = UIImage.init(named: "TestImage")
        
        return label
    }()
}

