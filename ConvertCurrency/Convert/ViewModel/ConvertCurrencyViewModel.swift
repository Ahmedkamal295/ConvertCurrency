//
//  ConvertCurrencyViewModel.swift
//  ConvertCurrency
//
//  Created by Ahmed Kamal on 09/12/2023.
//
import Foundation
import UIKit
import RxSwift
import RxCocoa

class ConvertCurrencyViewModel {
    
    // MARK: - Loading Behavior
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var convertCurrencyModelSubject = PublishSubject<[Rates]>()
    
    // MARK: - ConvertCurrencyModel Observable
    var convertCurrencyModelObservable: Observable<[Rates]> {
        return convertCurrencyModelSubject
    }
    
    func fetchData(completion: @escaping (Bool) -> Void) {
        let url = "http://data.fixer.io/api/latest?access_key=26962f454edb09a76d2691907b0c1961"
        loadingBehavior.accept(true)
        ApiServices.instance.FetchData(method: .get, url: url, parameters: [:], headers: [:]) { [weak self] (result: Result<ConvertCurrencyModel, Error>?, statusCode) in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch result {
            case .success(let model):
                if model.success == true {
            
                    if let rates = model.rates {
                        self.convertCurrencyModelSubject.onNext([rates])
                    }
                   
                    completion(true)
                } else {
                    completion(false)
                }
                print(model)
            case .failure(let error):
                print(error)
            case .none:
                print("error")
            }
        }
    }
}
