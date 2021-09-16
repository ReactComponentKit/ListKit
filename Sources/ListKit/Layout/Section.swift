//
//  Section.swift
//  ListKit
//
//  Created by burt on 2021/09/10.
//

import UIKit

public struct Section: Hashable {
    public let id: AnyHashable
    
    public static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    /// root group of this section
    internal let group: NSCollectionLayoutGroup
    /// section component for UICollectionViewCompositionalLayout
    internal let nsSection: NSCollectionLayoutSection
    /// components that are contained in this section
    internal var components: [AnyComponentWrapper] = []
    
    ///
    internal var decorationComponents: [AnyClass] = []
    
    public init<ID: Hashable>(id: ID, @GroupBuilder group: () -> GroupBuilderResult) {
        self.id = id
        let result = group()
        self.group = result.group
        self.nsSection = NSCollectionLayoutSection(group: self.group)
        
        for item in result.items {
            if let subgroup = item as? NSCollectionLayoutGroup {
                collectComponents(in: subgroup)
            } else {
                if let component = item.anyComponent as? AnyComponentWrapper {
                    components.append(component)
                }
            }
        }
    }
    
    private mutating func collectComponents(in group: NSCollectionLayoutGroup) {
        for item in group.subitems {
            if let subgroup = item as? NSCollectionLayoutGroup {
                collectComponents(in: subgroup)
            } else {
                if let component = item.anyComponent as? AnyComponentWrapper {
                    components.append(component)
                }
            }
        }
    }
    
    /// The section's scrolling behavior in relation to the main layout axis.
    public func orthogonalScrollingBehavior(_ value: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> Section {
        self.nsSection.orthogonalScrollingBehavior = value
        return self
    }
    
    /// The amount of space between the groups in the section.
    public func interGroupSpacing(_ value: CGFloat) -> Section {
        self.nsSection.interGroupSpacing = value
        return self
    }
    
    /// The amount of space between the content of the section and its boundaries.
    public func contentInsets(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> Section {
        self.nsSection.contentInsets = NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
        return self
    }
    
    /// The boundary to reference when defining content insets.
    @available(iOS 14.0, *)
    public func contentInsetsReference(_ value: UIContentInsetsReference) -> Section {
        self.nsSection.contentInsetsReference = value
        return self
    }
    
    /// A Boolean value that indicates whether the section's supplementary items follow the specified content insets for the section.
    public func supplementariesFollowContentInsets(_ value: Bool) -> Section {
        self.nsSection.supplementariesFollowContentInsets = value
        return self
    }
    
    /// An array of the supplementary items that are associated with the boundary edges of the section, such as headers and footers.
    public func boundarySupplementaryItem<S: SupplementaryComponent>(_ value: S) -> Section {
        SupplementaryComponentManager.shared.append(value)
        let item = value.toNSCollectionLayoutBoundarySupplementaryItem()
        self.nsSection.boundarySupplementaryItems.append(item)
        return self
    }
    
    /// An array of the decoration items that are anchored to the section, such as background decoration views.
    public func decorationItem<D: DecorationComponent>(_ value: D) -> Section {
        SupplementaryComponentManager.shared.append(value)
        let item = value.toNSCollectionLayoutDecorationItem()
        self.nsSection.decorationItems.append(item)
        return self
    }
    
    /// A closure called before each layout cycle to allow modification of the items in the section immediately before they are displayed.
    public func visibleItemsInvalidationHandler(_ value: NSCollectionLayoutSectionVisibleItemsInvalidationHandler?) -> Section {
        self.nsSection.visibleItemsInvalidationHandler = value
        return self
    }
}

extension Section: NSCollectionLayoutSectionConvertible {
    public var sections: [Section] {
        return [self]
    }
    
    public func toNSCollectionLayoutSections() -> [NSCollectionLayoutSection] {
        return [self.nsSection]
    }
}
