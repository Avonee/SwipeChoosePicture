//
//  selfScore.swift
//  SwipeChoosePicture
//
//  Created by rubl333 on 2017/2/28.
//  Copyright © 2017年 appcoda. All rights reserved.
//

import UIKit

class selfScore: UIViewController {
    @IBOutlet weak var selfNameLabel: UILabel!

    @IBOutlet weak var selfScoreLabel: UILabel!
    
    @IBOutlet weak var likedLabel: UILabel!
    @IBOutlet weak var dislikedLabel: UILabel!
    var percentGet:Float?
    var likedGet:Int?
    var dislikedGet:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if percentGet == nil{
            self.selfScoreLabel.text = "0"
            self.likedLabel.text = "0"
            self.dislikedLabel.text = "0"
        }else{
            self.selfScoreLabel.text = "\(Int(percentGet!*100))"
            self.likedLabel.text = "\(likedGet!)"
            self.dislikedLabel.text = "\(dislikedGet!)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
