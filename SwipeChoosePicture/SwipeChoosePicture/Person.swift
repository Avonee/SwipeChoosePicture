//
//  Person.swift
//  SwipeChoosePicture
//
//  Created by rubl333 on 2017/2/28.
//  Copyright © 2017年 appcoda. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    let Name: NSString
    let Image: UIImage!
    let Age: NSNumber
    let NumberOfSharedFriends: NSNumber?
    let NumberOfSharedInterests: NSNumber
    let NumberOfPhotos: NSNumber
    
    override var description: String {
        return "Name: \(Name), \n Image: \(Image), \n Age: \(Age) \n NumberOfSharedFriends: \(NumberOfSharedFriends) \n NumberOfSharedInterests: \(NumberOfSharedInterests) \n NumberOfPhotos/: \(NumberOfPhotos)"
    }
    
    init(name: NSString?, image: UIImage?, age: NSNumber?, sharedFriends: NSNumber?, sharedInterest: NSNumber?, photos:NSNumber?) {
        self.Name = name ?? ""
        self.Image = image
        self.Age = age ?? 0
        self.NumberOfSharedFriends = sharedFriends ?? 0
        self.NumberOfSharedInterests = sharedInterest ?? 0
        self.NumberOfPhotos = photos ?? 0
    }
}
