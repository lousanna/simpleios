//
//  CustomTabBarItem.swift
//  Blossom
//
//  Created by Lousanna Cai on 4/26/17.
//  Copyright © 2017 Lousanna Cai. All rights reserved.
//

import UIKit

class CustomTabBarItem: UIView {
    
    var iconView: UIImageView!
    
    var labelView: UILabel!
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ item: UITabBarItem) {
        
        guard let image = item.image else {
            fatalError("add images to tabbar items")
        }
        
        iconView = UIImageView(frame: CGRect(x: (self.frame.width-image.size.width)/2, y: (self.frame.height-image.size
            .height)/2, width: self.frame.width, height: self.frame.height))
        
        iconView.image = image
        iconView.sizeToFit()

        self.addSubview(iconView)
    }
    
}

