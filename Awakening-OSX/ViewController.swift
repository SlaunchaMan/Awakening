//
//  ViewController.swift
//  Awakening-OSX
//
//  Created by Jeff Kelley on 11/19/15.
//  Copyright © 2015 Detroit Labs. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var countdownLabel: NSTextField?
    
    var countdownTimer: NSTimer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let countdownLabel = countdownLabel {
            if let font = countdownLabel.font?.fontWithMonospaceDigits {
                countdownLabel.font = font
            }
        }
        
        countdownTimer =
        Countdown.defaultCountdown.registerForUpdates { string in
            guard let string = string else { return }
            
            self.countdownLabel?.stringValue = string
        }
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        
        countdownTimer?.invalidate()
        countdownTimer = nil
    }

}

