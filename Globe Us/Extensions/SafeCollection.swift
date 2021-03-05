//
//  SafeCollection.swift
//  Globe Us
//
//  Created by Karim on 28.02.2021.
//

import UIKit

extension Collection {
    var safe: SafeCollection<Self> {
        return SafeCollection(self)
    }
}


public struct SafeCollection<T : Collection> {

  private var base: T
  public init(_ base: T) {
    self.base = base
  }

  private func distance(from startIndex: T.Index) -> T.IndexDistance {
    return base.distance(from: startIndex, to: base.endIndex)
  }

  private func distance(to endIndex: T.Index) -> T.IndexDistance {
    return base.distance(from: base.startIndex, to: endIndex)
  }

  public subscript(index: T.Index) -> T.Iterator.Element? {
    if distance(to: index) >= 0 && distance(from: index) > 0 {
      return base[index]
    }
    return nil
  }

  public subscript(bounds: Range<T.Index>) -> T.SubSequence? {
    if distance(to: bounds.lowerBound) >= 0 && distance(from: bounds.upperBound) >= 0 {
      return base[bounds]
    }
    return nil
  }

  public subscript(bounds: ClosedRange<T.Index>) -> T.SubSequence? {
    if distance(to: bounds.lowerBound) >= 0 && distance(from: bounds.upperBound) > 0 {
      return base[bounds]
    }
    return nil
  }

}
