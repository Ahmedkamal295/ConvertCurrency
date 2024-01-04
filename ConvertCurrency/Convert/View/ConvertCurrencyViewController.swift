//
//  ConvertCurrencyViewController.swift
//  ConvertCurrency
//
//  Created by Ahmed Kamal on 09/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
class ConvertCurrencyViewController: UIViewController, UIScrollViewDelegate {

    //MARK: - out let
    @IBOutlet weak var stackFrom: UIStackView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var stackTo: UIStackView!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var tableViewListCurrency: UITableView!
    
    @IBOutlet weak var fromConvertCurrencyTextField: UITextField!
    @IBOutlet weak var toConvertCurrencyTextField: UITextField!
    @IBOutlet weak var detailsButton: UIButton!
    
    //MARK: - variable
    private let disposeBag = DisposeBag()
    private let viewModel = ConvertCurrencyViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        handelUI()
        registerCells()
        subscribeToResponse()
        subscribeToMySelection()
        subscribeToDetailsButton()
        listlCurrency()
        hideListTable()
        addTap()

    }
    //MARK: - func handel UI
    func handelUI() {
        detailsButton.layer.rx.borderWidth.onNext(1)
        detailsButton.layer.rx.borderColor.onNext(UIColor.black.cgColor)
        
        fromConvertCurrencyTextField.layer.rx.borderWidth.onNext(1)
        fromConvertCurrencyTextField.layer.rx.borderColor.onNext(UIColor.black.cgColor)
        
        toConvertCurrencyTextField.layer.rx.borderWidth.onNext(1)
        toConvertCurrencyTextField.layer.rx.borderColor.onNext(UIColor.black.cgColor)
        
        stackFrom.layer.rx.borderWidth.onNext(1)
        stackFrom.layer.rx.borderColor.onNext(UIColor.black.cgColor)
        
        stackTo.layer.rx.borderWidth.onNext(1)
        stackTo.layer.rx.borderColor.onNext(UIColor.black.cgColor)
    }
    //MARK: - add tap
    func addTap() {
        stackFrom.addTapGestureRecognizer(action: showListTable)
        stackTo.addTapGestureRecognizer(action: showListTable)
    }
    func showListTable() {
        tableViewListCurrency.rx.isHidden.onNext(false)
    }
    func hideListTable() {
        tableViewListCurrency.rx.isHidden.onNext(true)
    }
    //MARK: -  register Cell
    func registerCells() {
        tableViewListCurrency.registerCellNib(cellClass: ListCurrencyTableViewCell.self)
    }
    //MARK: -  subscribe To Response data
    func subscribeToResponse() {
        tableViewListCurrency.rx.setDelegate(self)
            .disposed(by: disposeBag)
        viewModel.convertCurrencyModelObservable.bind(to: tableViewListCurrency.rx.items(cellIdentifier: String(describing: ListCurrencyTableViewCell.self), cellType: ListCurrencyTableViewCell.self)) { indexPath, model, cell in
            
        }.disposed(by: disposeBag)
    }
    //MARK: -  subscribe To Selection item function
    func subscribeToMySelection() {
        Observable.zip(tableViewListCurrency.rx.itemSelected, tableViewListCurrency.rx.modelSelected(Rates.self))
            .bind { [unowned self] indexPath, model in
                print(model)
                hideListTable()
            }.disposed(by: disposeBag)
    }
    //MARK: - listl Currency
    func listlCurrency(){
        viewModel.fetchData { done in
            if done {
                self.tableViewListCurrency.reloadData()
            }
        }
    }
    //MARK: - subscribe To Details Button
    func subscribeToDetailsButton() {
        detailsButton.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [weak self] event in
               
            }.disposed(by: disposeBag)
    }

}
