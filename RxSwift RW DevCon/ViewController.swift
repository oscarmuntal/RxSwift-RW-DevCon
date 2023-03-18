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
        
    }


}

struct StockPrice {
    
}
