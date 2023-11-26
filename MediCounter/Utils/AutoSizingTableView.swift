//
//  AutoSizingTableView.swift
//  MediCounter
//

import Foundation
import UIKit

final public class AutoSizingTableView: UITableView {
    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
