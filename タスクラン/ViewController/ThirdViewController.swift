//
//  ThirdViewController.swift
//  タスクラン
//
//  Created by Kato Ryota  on 28/12/19.
//  Copyright © 2019 Kato Ryota . All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var taskTimeSum = 0
    var breakTimeSum = 0
    
    @IBOutlet weak var taskTimeSumLabel: UILabel!
    @IBOutlet weak var breakTimeSumLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        topButton.layer.cornerRadius = 30.0
        taskTimeSumLabel.text = String(taskTimeSum) + "分"
        breakTimeSumLabel.text = String(breakTimeSum) + "分"
    }
    

    @IBAction func topButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToTopView", sender: self)

    }
    
}
