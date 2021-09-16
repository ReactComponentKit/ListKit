//
//  ListKitReusableView.swift
//  ListKit
//
//  Created by burt on 2021/09/15.
//

import UIKit

internal class ListKitReusableView: UICollectionReusableView {
}

extension ListKitReusableView {
    static var className: String {
        return String(reflecting: Self.self)
    }
    
    internal override var reuseIdentifier: String? {
        return Self.className
    }
}
