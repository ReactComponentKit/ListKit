//
//  UICollectionViewExtensions.swift
//  ListKit
//
//  Created by burt on 2021/09/21.
//

import UIKit

extension UICollectionView {
    /// unregistering supplementary view of kind
    /// In Apple Docs, You may specify nil for viewClass if you want to unregister the class from the specified element kind and reuse identifier.
    func unregisterSupplementaryView(kind: String, withReuseIdentifier reuseIdentifier: String) {
        // need it to prevent Ambiguous use of 'register(_:forSupplementaryViewOfKind:withReuseIdentifier:)'
        let nilAnyClass: AnyClass? = nil
        self.register(nilAnyClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
    }
}
