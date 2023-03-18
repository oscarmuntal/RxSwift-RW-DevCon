//
//  StockCell.swift
//  RxSwift RW DevCon
//
//  Created by Òscar Muntal on 18/3/23.
//

import UIKit

class StockCell: UITableViewCell {
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var price: UILabel!

    public func update(with stockPrice: StockPrice) {
        symbol.text = stockPrice.symbol
    }
}
