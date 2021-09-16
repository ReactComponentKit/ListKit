//
//  NSCollectionLayoutSectionConvertible.swift
//  ListKit
//
//  Created by burt on 2021/09/12.
//

import UIKit

public protocol NSCollectionLayoutSectionConvertible {
    var sections: [Section] { get }
    func toNSCollectionLayoutSections() -> [NSCollectionLayoutSection]
}

extension SectionBuilderResult: NSCollectionLayoutSectionConvertible {
    public func toNSCollectionLayoutSections() -> [NSCollectionLayoutSection] {
        return self.nsSections
    }
}

extension Array: NSCollectionLayoutSectionConvertible where Element: SectionBuilderResult {
    public var sections: [Section] {
        return self.flatMap { $0.sections }
    }
    
    public func toNSCollectionLayoutSections() -> [NSCollectionLayoutSection] {
        return self.flatMap { $0.nsSections }
    }
}
