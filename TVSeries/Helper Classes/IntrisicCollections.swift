//
//  IntrisicCollections.swift
//  Boxifarma
//
//  Created by Bruno Scheltzke on 13/06/20.
//  Copyright © 2020 App5m. All rights reserved.
//

import UIKit

final class IntrinsicTableView: UITableView {

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    override func reloadData() {
        super.reloadData()
        layoutIfNeeded()
    }
    
}

final class IntrinsicCollectionView: UICollectionView {

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    override func reloadData() {
        super.reloadData()
        layoutIfNeeded()
    }
    
}

final class IntrisicScrollView: UIScrollView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}
