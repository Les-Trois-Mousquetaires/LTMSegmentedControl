//
//  LTMSegmentedControl.swift
//  LTMSegmentedControl
//
//  Created by 柯南 on 2020/5/18.
//  Copyright © 2020 LTM. All rights reserved.
//

import UIKit

class LTMSegmentedControl: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        self.config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.selectedSegmentIndex = 0
        self.configRemoveDividerImage()
        self.configBackgroundImage()
        self.configNormalColorAndFont(normalColor: .brown, normalFont: .systemFont(ofSize: 15))
        self.configSelectedColorAndFont(selectedColor: UIColor.white, selectedFont: .systemFont(ofSize: 30))
    }
    
    /**
     配置默认颜色和字体
     */
    func configNormalColorAndFont(normalColor: UIColor, normalFont: UIFont){
        let normalDic:NSDictionary = [NSAttributedString.Key.foregroundColor:normalColor,NSAttributedString.Key.font:normalFont];
        self.setTitleTextAttributes(normalDic as? [NSAttributedString.Key : Any], for: .normal)
    }
    /**
     配置选中颜色和字体
     */
    func configSelectedColorAndFont(selectedColor: UIColor, selectedFont: UIFont){
        let selectedDic:NSDictionary = [NSAttributedString.Key.foregroundColor:selectedColor,NSAttributedString.Key.font:selectedFont];
        self.setTitleTextAttributes(selectedDic as? [NSAttributedString.Key : Any], for: .selected)
    }
    /**
     删除分割线
     */
    func configRemoveDividerImage(){
        self.setDividerImage(UIImage.init(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    func configBackgroundImage(){
        self.setBackgroundImage(UIImage.init(color: UIColor.clear), for: .normal, barMetrics: .default)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0
    }
    
}

//MARK: - Image
extension UIImage{
    //用颜色生成图片
    convenience init(color: UIColor) {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        let path = UIBezierPath(rect: CGRect(origin: .zero, size: .zero))
        color.set()
        path.fill()
        let image :UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image.cgImage)!)
    }
    
    //图片宽高百分比缩放
    func conver(quality: Float) -> UIImage? {
        if let data = self.jpegData(compressionQuality: CGFloat(quality)), let photo = UIImage(data: data) {
            return photo
        }
        return UIImage()
    }
    
}
