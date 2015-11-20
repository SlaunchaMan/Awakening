//
//  MonospacedFont.swift
//  Awakening
//
//  Created by Jeff Kelley on 11/19/15.
//  Copyright © 2015 Detroit Labs. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
    
    typealias Font = UIFont
    typealias FontDescriptor = UIFontDescriptor
    
    private let fontFeatureTypeIdentifierKey = UIFontFeatureTypeIdentifierKey
    private let fontFeatureSelectorIdentifierKey = UIFontFeatureSelectorIdentifierKey
    private let fontDescriptorFeatureSettingsAttribute = UIFontDescriptorFeatureSettingsAttribute
#elseif os(OSX)
    import AppKit
    
    typealias Font = NSFont
    typealias FontDescriptor = NSFontDescriptor
    
    private let fontFeatureTypeIdentifierKey = NSFontFeatureTypeIdentifierKey
    private let fontFeatureSelectorIdentifierKey = NSFontFeatureSelectorIdentifierKey
    private let fontDescriptorFeatureSettingsAttribute = NSFontFeatureSettingsAttribute
#endif

extension Font {
    
    var fontWithMonospaceDigits: Font? {
        #if os(OSX)
        let currentDescriptor = fontDescriptor
        #else
        let currentDescriptor = fontDescriptor()
        #endif
        
        let newFontDescriptor = currentDescriptor.fontDescriptorForMonospaceDigits
        return Font(descriptor: newFontDescriptor, size: pointSize)
    }
    
}

private extension FontDescriptor {
    
    var fontDescriptorForMonospaceDigits: FontDescriptor {
        let fontDescriptorFeatureSettings = [[
            fontFeatureTypeIdentifierKey: kNumberSpacingType,
            fontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
        ]]
        
        let fontDescriptorAttributes =
        [fontDescriptorFeatureSettingsAttribute: fontDescriptorFeatureSettings]
        
        let fontDescriptor = fontDescriptorByAddingAttributes(fontDescriptorAttributes)
        
        return fontDescriptor
    }
    
}
