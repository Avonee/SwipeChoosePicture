//
//  ViewController.swift
//  SwipeChoosePicture
//
//  Created by rubl333 on 2017/2/28.
//  Copyright © 2017年 appcoda. All rights reserved.
//

import UIKit
import MDCSwipeToChoose

class ViewController: UIViewController, MDCSwipeToChooseDelegate {
    
    var people:[Person] = []
    let ChoosePersonButtonHorizontalPadding:CGFloat = 80.0
    let ChoosePersonButtonVerticalPadding:CGFloat = 20.0
    var currentPerson:Person!
    var frontCardView:ChoosePersonView!
    var backCardView:ChoosePersonView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.people = defaultPeople()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.people = defaultPeople()
        // Here you can init your properties
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // Display the first ChoosePersonView in front. Users can swipe to indicate
        // whether they like or dislike the person displayed.
        self.setMyFrontCardView(self.popPersonViewWithFrame(frontCardViewFrame())!)
        self.view.addSubview(self.frontCardView)
        
        // Display the second ChoosePersonView in back. This view controller uses
        // the MDCSwipeToChooseDelegate protocol methods to update the front and
        // back views after each user swipe.
        self.backCardView = self.popPersonViewWithFrame(backCardViewFrame())!
        self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
        
        // Add buttons to programmatically swipe the view left or right.
        // See the `nopeFrontCardView` and `likeFrontCardView` methods.
        constructNopeButton()
        constructLikedButton()
    }
    func suportedInterfaceOrientations() -> UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    
    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(_ view: UIView) -> Void{
        
        print("You couldn't decide on \(self.currentPerson.Name)");
    }
    
    // This is called then a user swipes the view fully left or right.
    func view(_ view: UIView, wasChosenWith wasChosenWithDirection: MDCSwipeDirection) -> Void{
        
        // MDCSwipeToChooseView shows "NOPE" on swipes to the left,
        // and "LIKED" on swipes to the right.
        if(wasChosenWithDirection == MDCSwipeDirection.left){
            print("You noped: \(self.currentPerson.Name)")
        }
        else{
            
            print("You liked: \(self.currentPerson.Name)")
        }
        
        // MDCSwipeToChooseView removes the view from the view hierarchy
        // after it is swiped (this behavior can be customized via the
        // MDCSwipeOptions class). Since the front card view is gone, we
        // move the back card to the front, and create a new back card.
        if(self.backCardView != nil){
            self.setMyFrontCardView(self.backCardView)
        }
        
        backCardView = self.popPersonViewWithFrame(self.backCardViewFrame())
        //if(true){
        // Fade the back card into view.
        if(backCardView != nil){
            self.backCardView.alpha = 0.0
            self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.backCardView.alpha = 1.0
            },completion:nil)
        }
    }
    func setMyFrontCardView(_ frontCardView:ChoosePersonView) -> Void{
        
        // Keep track of the person currently being chosen.
        // Quick and dirty, just for the purposes of this sample app.
        self.frontCardView = frontCardView
        self.currentPerson = frontCardView.person
    }
    
    func defaultPeople() -> [Person]{
        // It would be trivial to download these from a web service
        // as needed, but for the purposes of this sample app we'll
        // simply store them in memory.
        return [Person(name: "Finn", image: UIImage(named: "finn"), age: 21, sharedFriends: 3, sharedInterest: 4, photos: 5), Person(name: "Jake", image: UIImage(named: "jake"), age: 21, sharedFriends: 3, sharedInterest: 4, photos: 5), Person(name: "Fiona", image: UIImage(named: "fiona"), age: 21, sharedFriends: 3, sharedInterest: 4, photos: 5), Person(name: "P.Gumball", image: UIImage(named: "prince"), age: 21, sharedFriends: 3, sharedInterest: 4, photos: 5)]
        
    }
    func popPersonViewWithFrame(_ frame:CGRect) -> ChoosePersonView?{
        if(self.people.count == 0){
            return nil;
        }
        
        // UIView+MDCSwipeToChoose and MDCSwipeToChooseView are heavily customizable.
        // Each take an "options" argument. Here, we specify the view controller as
        // a delegate, and provide a custom callback that moves the back card view
        // based on how far the user has panned the front card view.
        let options:MDCSwipeToChooseViewOptions = MDCSwipeToChooseViewOptions()
        options.delegate = self
        //options.threshold = 160.0
        options.onPan = { state -> Void in
            if(self.backCardView != nil){
                let frame:CGRect = self.frontCardViewFrame()
                self.backCardView.frame = CGRect(x:frame.origin.x, y:frame.origin.y-((state?.thresholdRatio)! * 10.0), width:frame.width, height:frame.height)
            }
        }
        
        // Create a personView with the top person in the people array, then pop
        // that person off the stack.
        
        let personView:ChoosePersonView = ChoosePersonView(frame: frame, person: self.people[0], options: options)
        self.people.remove(at: 0)
        return personView
        
    }
    func frontCardViewFrame() -> CGRect{
        let horizontalPadding:CGFloat = 20.0
        let topPadding:CGFloat = 60.0
        let bottomPadding:CGFloat = 200.0
        return CGRect(x: horizontalPadding,y: topPadding,width: (self.view.frame).width - (horizontalPadding * 2), height: (self.view.frame).height - bottomPadding)
    }
    func backCardViewFrame() ->CGRect{
        let frontFrame:CGRect = frontCardViewFrame()
        return CGRect(x: frontFrame.origin.x, y: frontFrame.origin.y + 10.0, width: frontFrame.width, height: frontFrame.height)
    }
    func constructNopeButton() -> Void{
        let button:UIButton =  UIButton(type: UIButtonType.system)
        let image:UIImage = UIImage(named:"nope")!
        button.frame = CGRect(x: ChoosePersonButtonHorizontalPadding, y: (self.frontCardView.frame).maxY + ChoosePersonButtonVerticalPadding, width: image.size.width, height: image.size.height)
        button.setImage(image, for: UIControlState())
        button.tintColor = UIColor(red: 247.0/255.0, green: 91.0/255.0, blue: 37.0/255.0, alpha: 1.0)
        button.addTarget(self, action: #selector(ViewController.nopeFrontCardView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    
    func constructLikedButton() -> Void{
        let button:UIButton = UIButton(type: UIButtonType.system)
        let image:UIImage = UIImage(named:"liked")!
        button.frame = CGRect(x: (self.view.frame).maxX - image.size.width - ChoosePersonButtonHorizontalPadding, y: (self.frontCardView.frame).maxY + ChoosePersonButtonVerticalPadding, width: image.size.width, height: image.size.height)
        button.setImage(image, for:UIControlState())
        button.tintColor = UIColor(red: 29.0/255.0, green: 245.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        button.addTarget(self, action: #selector(ViewController.likeFrontCardView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
    }
    func nopeFrontCardView() -> Void{
        self.frontCardView.mdc_swipe(MDCSwipeDirection.left)
    }
    func likeFrontCardView() -> Void{
        self.frontCardView.mdc_swipe(MDCSwipeDirection.right)
    }
}

