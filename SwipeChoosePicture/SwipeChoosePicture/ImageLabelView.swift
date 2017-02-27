//
//  ImageLabelView.swift
//  SwipeChoosePicture
//
//  Created by rubl333 on 2017/2/28.
//  Copyright © 2017年 appcoda. All rights reserved.
//

import UIKit

class ImagelabelView: UIView{
    var imageView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        imageView = UIImageView()
        label = UILabel()
    }
    
    init(frame: CGRect, image: UIImage, text: String) {
        
        super.init(frame: frame)
        constructImageView(image)
        constructLabel(text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func constructImageView(_ image:UIImage) -> Void{
        
        let topPadding:CGFloat = 10.0
        
        let framex = CGRect(x: floor((self.bounds.width - image.size.width)/2),
                            y: topPadding,
                            width: image.size.width,
                            height: image.size.height)
        imageView = UIImageView(frame: framex)
        imageView.image = image
        addSubview(self.imageView)
    }
    
    func constructLabel(_ text:String) -> Void{
        let height:CGFloat = 18.0
        let frame2 = CGRect(x: 0,
                            y: self.imageView.frame.maxY,
                            width: self.bounds.width,
                            height: height);
        self.label = UILabel(frame: frame2)
        label.text = text
        addSubview(label)
        
    }
}
