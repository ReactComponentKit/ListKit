//
//  ListKitCell.swift
//  ListKit
//
//  Created by burt on 2021/09/11.
//

import UIKit

internal class ListKitCell: UICollectionViewCell {
}

extension ListKitCell {
    static var className: String {
        return String(reflecting: Self.self)
    }
    
    internal override var reuseIdentifier: String? {
        return Self.className
    }
}
