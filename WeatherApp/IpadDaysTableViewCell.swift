//
//  IpadDaysTableViewCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 13.07.2021.
//

import UIKit

class IpadDaysTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDegree: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    private var viewDataItem: ListViewData!
    private var viewModel: MainViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//
//    func configureCell(date: String, day: String, degree: String) {
//
//        self.lblDate.text = date
//        self.lblDay.text = day
//        self.lblDegree.text = degree
//    }
//
    
    func configure(with item: ListViewData, viewModel: MainViewModel) {
        viewDataItem = item
        self.viewModel = viewModel
      
        if item.isSelected {
            self.backgroundColor = .red
        } else {
            self.backgroundColor = .clear
        }
        
        self.lblDate.text = viewDataItem.dayAndMonth
        self.lblDay.text = viewDataItem.dayName
        self.lblDegree.text = viewDataItem.degree
    }

}
