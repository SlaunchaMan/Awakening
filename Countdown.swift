//
//  Countdown.swift
//  Awakening
//
//  Created by Jeff Kelley on 11/19/15.
//  Copyright © 2015 Detroit Labs. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    import QuartzCore
#endif

class Countdown {
    
    private class UpdateHandler {
        let updateBlock: Void -> Void
        
        init(updateBlock: Void -> Void) {
            self.updateBlock = updateBlock
        }
        
        #if os(iOS) || os(tvOS)
        @objc func update(displayLink: CADisplayLink) {
        	updateBlock()
        }
        #else
        @objc func update(timer: NSTimer) {
             updateBlock()
        }
        #endif
    }
    
    static let defaultCountdown = Countdown()
    
    let countdownDate: NSDate
    
    init() {
        let components = NSDateComponents()
        
        components.year = 2015
        components.month = 12
        components.day = 17
        
        components.hour = 19
        components.minute = 0
        components.second = 0
        
        components.timeZone = NSTimeZone(name: "America/Detroit")
        
        countdownDate = NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    lazy var dateComponentsFormatter: NSDateComponentsFormatter = {
        let formatter = NSDateComponentsFormatter()
        formatter.allowedUnits = [.Day, .Hour, .Minute, .Second]
        formatter.unitsStyle = .Positional
        return formatter
    }()
    
    lazy var nanosecondFormatter: NSNumberFormatter = {
        let nanosecondFormatter = NSNumberFormatter()
        nanosecondFormatter.minimumIntegerDigits = 9
        
        return nanosecondFormatter
    }()
    
    #if os(iOS) || os(tvOS)
    typealias UpdateRegistration = CADisplayLink
    #else
    typealias UpdateRegistration = NSTimer
    #endif
    
    func registerForUpdates(updateHandler: String? -> Void) -> UpdateRegistration? {
        let timerHandler = UpdateHandler {
            let dateComponents = NSCalendar.currentCalendar()
                .components([.Day, .Hour, .Minute, .Second, .Nanosecond],
                    fromDate: NSDate(),
                    toDate: self.countdownDate,
                    options: NSCalendarOptions())
            
            guard let formattedDate = self.dateComponentsFormatter.stringFromDateComponents(dateComponents) else { return }
            
            guard let formattedNanosecond = self.nanosecondFormatter.stringFromNumber(dateComponents.nanosecond) else { return}
            
            updateHandler(formattedDate + "." + formattedNanosecond)
        }
        
        #if os(iOS) || os(tvOS)
            let displayLink = CADisplayLink(target: timerHandler, selector: "update:")
            
            displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
            
            return displayLink
        #else
            return NSTimer.scheduledTimerWithTimeInterval(1.0 / 60.0,
                target: timerHandler,
                selector: "update:",
                userInfo: nil,
                repeats: true)
        #endif
    }
    
}
