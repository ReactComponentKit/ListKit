//
//  NSCollectionLayoutGroupConvertible.swift
//  ListKit
//
//  Created by burt on 2021/09/11.
//

import UIKit

public protocol NSCollectionLayoutGroupConvertible {
    var items: [NSCollectionLayoutItem] { get }
    func toNSCollectionLayoutGroup() -> NSCollectionLayoutGroup
}

extension GroupBuilderResult: NSCollectionLayoutGroupConvertible {
    public func toNSCollectionLayoutGroup() -> NSCollectionLayoutGroup {
        self.group
    }
}
