//
//  RegisterCell.swift
//  ConvertCurrency
//
//  Created by Ahmed Kamal on 09/12/2023.
//

import Foundation
import UIKit
//MARK: - Generic Register UITableViewCell
extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type){
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
}
