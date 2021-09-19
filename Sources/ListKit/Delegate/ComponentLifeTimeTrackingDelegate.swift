//
//  ComponentLifeTimeTrackingDelegate.swift
//  ListKit
//
//  Created by burt on 2021/09/19.
//

import UIKit

open class ComponentLifeTimeTrackingDelegate: NSObject, ListKitDelegate, UICollectionViewDelegate {
    public var layout: ComposeLayout?

    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let component = anyComponent(at: indexPath), let contentView = cell.contentView.viewWithTag(ListKit.componentContentViewTag) {
            component.willDisplay(content: contentView)
        }
    }

    open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let component = anyComponent(at: indexPath), let contentView = cell.contentView.viewWithTag(ListKit.componentContentViewTag) {
            component.didEndDisplay(content: contentView)
        }
    }
}
