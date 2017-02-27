//
//  ChoosePersonView.swift
//  SwipeChoosePicture
//
//  Created by rubl333 on 2017/2/28.
//  Copyright © 2017年 appcoda. All rights reserved.
//

import UIKit
import MDCSwipeToChoose

class ChoosePersonView: MDCSwipeToChooseView {
    
    let ChoosePersonViewImageLabelWidth:CGFloat = 42.0;
    var person: Person!
    var informationView: UIView!
    var nameLabel: UILabel!
    var carmeraImageLabelView:ImagelabelView!
    var interestsImageLabelView: ImagelabelView!
    var friendsImageLabelView: ImagelabelView!
    
    init(frame: CGRect, person: Person, options: MDCSwipeToChooseViewOptions) {
        
        super.init(frame: frame, options: options)
        self.person = person
        
        if let image = self.person.Image {
            self.imageView.image = image
        }
        
        self.autoresizingMask = [UIViewAutoresizing.flexibleHeight
            , UIViewAutoresizing.flexibleWidth]
        UIViewAutoresizing.flexibleBottomMargin
        
        self.imageView.autoresizingMask = self.autoresizingMask
        constructInformationView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func constructInformationView() -> Void{
        let bottomHeight:CGFloat = 60.0
        let bottomFrame:CGRect = CGRect(x: 0,
                                        y: (self.bounds).height - bottomHeight,
                                        width: (self.bounds).width,
                                        height: bottomHeight);
        self.informationView = UIView(frame:bottomFrame)
        self.informationView.backgroundColor = UIColor.white
        self.informationView.clipsToBounds = true
        self.informationView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleTopMargin]
        self.addSubview(self.informationView)
        constructNameLabel()
        constructCameraImageLabelView()
        constructInterestsImageLabelView()
        constructFriendsImageLabelView()
    }
    
    func constructNameLabel() -> Void{
        let leftPadding:CGFloat = 12.0
        let topPadding:CGFloat = 17.0
        let frame:CGRect = CGRect(x: leftPadding,
                                  y: topPadding,
                                  width: floor(self.informationView.frame.width/2),
                                  height: self.informationView.frame.height - topPadding)
        self.nameLabel = UILabel(frame:frame)
        self.nameLabel.text = "\(person.Name), \(person.Age)"
        self.informationView .addSubview(self.nameLabel)
    }
    func constructCameraImageLabelView() -> Void{
        var rightPadding:CGFloat = 10.0
        let image:UIImage = UIImage(named:"camera")!
        self.carmeraImageLabelView = buildImageLabelViewLeftOf(self.informationView.bounds.width, image:image, text:person.NumberOfPhotos.stringValue)
        self.informationView.addSubview(self.carmeraImageLabelView)
    }
    func constructInterestsImageLabelView() -> Void{
        let image: UIImage = UIImage(named: "book")!
        self.interestsImageLabelView = self.buildImageLabelViewLeftOf(self.carmeraImageLabelView.frame.minX, image: image, text:person.NumberOfPhotos.stringValue)
        self.informationView.addSubview(self.interestsImageLabelView)
    }
    
    func constructFriendsImageLabelView() -> Void{
        let image:UIImage = UIImage(named:"group")!
        self.friendsImageLabelView = buildImageLabelViewLeftOf(self.interestsImageLabelView.frame.minX, image:image, text:"No Friends")
        self.informationView.addSubview(self.friendsImageLabelView)
    }
    
    func buildImageLabelViewLeftOf(_ x:CGFloat, image:UIImage, text:String) -> ImagelabelView{
        let frame:CGRect = CGRect(x:x-ChoosePersonViewImageLabelWidth, y: 0,
                                  width: ChoosePersonViewImageLabelWidth,
                                  height: self.informationView.bounds.height)
        let view:ImagelabelView = ImagelabelView(frame:frame, image:image, text:text)
        view.autoresizingMask = UIViewAutoresizing.flexibleLeftMargin
        return view
    }
}
