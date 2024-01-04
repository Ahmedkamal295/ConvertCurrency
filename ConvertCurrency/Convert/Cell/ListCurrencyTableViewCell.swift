//
//  ListCurrencyTableViewCell.swift
//  ConvertCurrency
//
//  Created by Ahmed Kamal on 09/12/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ListCurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with currency: String, rate: Double) {
        currencyNameLabel.text = currency
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
