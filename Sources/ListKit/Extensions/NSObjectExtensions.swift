//
//  NSObjectExtensions.swift
//  ListKit
//
//  Created by burt on 2021/09/12.
//

import Foundation

extension NSObject {
    private static let componentAssociation = AnyObjectAssociation()
    
    var anyComponent: AnyObject? {
        get {
            return NSObject.componentAssociation[self]
        }
        set {
            NSObject.componentAssociation[self] = newValue
        }
    }
}
