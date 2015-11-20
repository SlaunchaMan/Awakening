//
//  ViewController.swift
//  Awakening-iOS
//
//  Created by Jeff Kelley on 11/19/15.
//  Copyright © 2015 Detroit Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countdownLabel: UILabel?
    
    var countdownDisplayLink: CADisplayLink? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let countdownLabel = countdownLabel {
            countdownLabel.font = countdownLabel.font.fontWithMonospaceDigits
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        countdownDisplayLink =
        Countdown.defaultCountdown.registerForUpdates { string in
            self.countdownLabel?.text = string
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        countdownDisplayLink?.invalidate()
        countdownDisplayLink = nil
    }

}

