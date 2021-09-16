//
//  GroupBuilder.swift
//  ListKit
//
//  Created by burt on 2021/09/12.
//

import UIKit

public struct GroupBuilderResult {
    public let group: NSCollectionLayoutGroup
    public let items: [NSCollectionLayoutItem]
}

@resultBuilder
public struct GroupBuilder {
    public static func buildBlock(_ components: NSCollectionLayoutGroupConvertible...) -> GroupBuilderResult {
        precondition(components.count == 1, "Section contains only one Group!")
        guard let group = components.first else {
            fatalError("Section must have only one root Group!")
        }
        return GroupBuilderResult(group: group.toNSCollectionLayoutGroup(), items: group.items)
    }
    
    public static func buildFinalResult(_ component: GroupBuilderResult) -> GroupBuilderResult {
        return component
    }
    
    /// support if block
    public static func buildOptional(_ component: [NSCollectionLayoutGroupConvertible]?) -> [GroupBuilderResult] {
        return component?.compactMap { GroupBuilderResult(group: $0.toNSCollectionLayoutGroup(), items: $0.items) } ?? []
    }
    
    /// support if-else block (if)
    public static func buildEither(first component: GroupBuilderResult) -> GroupBuilderResult {
        return component
    }
    
    /// support if-else block (else)
    public static func buildEither(second component: GroupBuilderResult) -> GroupBuilderResult {
        return component
    }
    
    /// GroupBuilder does not support for-in loop
}
