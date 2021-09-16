//
//  ComposeLayout.swift
//  ListKit
//
//  Created by burt on 2021/09/11.
//

import UIKit

public struct ComposeLayout {
    public private(set) var sections: [Section]
    public private(set) var layout: UICollectionViewCompositionalLayout
    private let nsSections: [NSCollectionLayoutSection]
    
    public init(configuration: UICollectionViewCompositionalLayoutConfiguration?, @SectionBuilder sections: () -> [SectionBuilderResult]) {
        let result = sections()
        let flattendSections = result.flatMap { $0.sections }
        let flattendNSSections = result.flatMap { $0.nsSections }
        
        if let configuration = configuration {
            self.layout = UICollectionViewCompositionalLayout(sectionProvider: { index, environment in
                return flattendNSSections[index]
            }, configuration: configuration)
        } else {
            self.layout = UICollectionViewCompositionalLayout(sectionProvider: { index, environment in
                return flattendNSSections[index]
            })
        }
        self.sections = flattendSections
        self.nsSections = flattendNSSections
        
        /// register decoration views
        SupplementaryComponentManager.shared.decorationComponents.forEach {
            self.layout.register($0, forDecorationViewOfKind: "\($0)")
        }
    }
    
    public init<T>(configuration: UICollectionViewCompositionalLayoutConfiguration?, of items: [T], builder: (T) -> NSCollectionLayoutSectionConvertible) {
        self.init(configuration: configuration) {
            for item in items {
                builder(item)
            }
        }
    }
}
