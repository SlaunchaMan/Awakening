//
//  InterfaceController.swift
//  Awakening-watchOS Extension
//
//  Created by Jeff Kelley on 11/19/15.
//  Copyright © 2015 Detroit Labs. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var countdownTimer: WKInterfaceTimer!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        countdownTimer.setDate(Countdown.defaultCountdown.countdownDate)
    }


}
