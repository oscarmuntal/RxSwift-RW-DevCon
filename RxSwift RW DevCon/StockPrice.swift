//
//  StockPrice.swift
//  RxSwift RW DevCon
//
//  Created by Òscar Muntal on 4/4/23.
//

import Foundation
import RxSwift
import RxRelay

struct StockPrice {
    public let symbol: String
    public var isFavorite: Bool = false
    private let price = BehaviorRelay<Double>(value: 0)
    var priceObservable: Observable<Double> {
        return price.asObservable()
    }
    
    init(symbol: String, favorite: Bool) {
        self.symbol = symbol
        self.isFavorite = favorite
    }
    
    func update(_ price: Double) {
        self.price.accept(price)
    }
}
