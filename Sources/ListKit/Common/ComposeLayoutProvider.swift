//
//  ComposeLayoutProvider.swift
//  ListKit
//
//  Created by burt on 2021/09/19.
//
import Foundation

public protocol ComposeLayoutProvider {
    /// UICollectionView's current compose layout
    var layout: ComposeLayout? { get set }
}
