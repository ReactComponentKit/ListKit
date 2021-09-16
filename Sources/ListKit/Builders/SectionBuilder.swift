//
//  SectionBuilder.swift
//  ListKit
//
//  Created by burt on 2021/09/12.
//

import UIKit

public class SectionBuilderResult: NSObject {
    public let sections: [Section]
    public let nsSections: [NSCollectionLayoutSection]
    
    public init(sections: [Section], nsSections: [NSCollectionLayoutSection]) {
        self.sections = sections
        self.nsSections = nsSections
    }
}

@resultBuilder
public struct SectionBuilder {
    public static func buildBlock(_ components: NSCollectionLayoutSectionConvertible...) -> [SectionBuilderResult] {
        return components.compactMap { SectionBuilderResult(sections: $0.sections, nsSections: $0.toNSCollectionLayoutSections()) }
    }
    
    public static func buildFinalResult(_ component: [SectionBuilderResult]) -> [SectionBuilderResult] {
        return component
    }
    
    /// support if block
    public static func buildOptional(_ component: [SectionBuilderResult]?) -> [SectionBuilderResult] {
        return component ?? []
    }
    
    /// support if-else block (if)
    public static func buildEither(first component: [SectionBuilderResult]) -> [SectionBuilderResult] {
        return component
    }
    
    /// support if-else block (else)
    public static func buildEither(second component: [SectionBuilderResult]) -> [SectionBuilderResult] {
        return component
    }
    
    /// support for-in loop
    public static func buildArray(_ components: [[SectionBuilderResult]]) -> [SectionBuilderResult] {
        let result = components.flatMap { $0 }
        return result
    }
}
