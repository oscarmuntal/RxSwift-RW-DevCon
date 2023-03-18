//
//  ViewController.swift
//  RxSwift RW DevCon
//
//  Created by Òscar Muntal on 17/3/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    fileprivate let bag = DisposeBag()
    fileprivate let allSymbols = ["RZW", "UDP", "MTT", "ZKQ", "IPK", "AQÜ"]
    fileprivate let allPrices = BehaviorRelay<[StockPrice]>(value: [])
    fileprivate let prices = BehaviorRelay<[StockPrice]>(value: [])
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var favoritesSwitch: UISwitch!
    @IBOutlet var searchTerm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let all = allSymbols.enumerated().map { index, symbol in
            return StockPrice(symbol: symbol, favorite: index % 2 == 0)
        }
        allPrices.accept(all)
        
        bindUI()
    }
}

private extension ViewController {
    func bindUI() {
        Observable.combineLatest(
            allPrices.asObservable(),
            favoritesSwitch.rx.isOn,
            searchTerm.rx.text) { currentPrices, onlyFavorite, search in
                print("\(currentPrices) \(onlyFavorite) \(String(describing: search))")
            }
            .subscribe()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prices.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell") as! StockCell
        let price = prices.value[indexPath.row]
        cell.update(with: price)
        return cell
    }
}

fileprivate func shouldDisplayPrice(price: StockPrice, onlyFavorites: Bool, search: String?) -> Bool {
    if onlyFavorites && !price.isFavorite {
        return false
    }
    if let search = search,
       !search.isEmpty,
       !price.symbol.contains(search) {
        return false
    }
    return true
}

fileprivate func update(prices: [StockPrice], with newPrices: [String: Double]) -> [StockPrice] {
    for (key, newPrice) in newPrices {
        if let stockPrice = prices.filter({ $0.symbol == key }).first {
            stockPrice.update(newPrice)
        }
    }
    return prices
}
