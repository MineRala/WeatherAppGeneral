//
//  DaysTableViewCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 11.07.2021.
//

import UIKit

class DaysTableViewCell: UITableViewCell ,UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    

    @IBOutlet weak var collectionViewDays: UICollectionView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var labelDayName: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var labelDegree: UILabel!
   
    private var viewDataItem: ListViewDataModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.cellContentView.backgroundColor = C.Color.cellContentViewColor
        self.cellView.backgroundColor = C.Color.cellViewColor
        cellView.layer.cornerRadius = 8
        cellView.daysItemShadow()
        collectionViewDays.register(UINib(nibName: "DaysCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DaysCollectionViewCell")
        self.collectionViewDays.delegate = self
        self.collectionViewDays.dataSource = self
        self.collectionViewDays.backgroundColor = .clear
    }
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCollectionViewCell", for: indexPath) as! DaysCollectionViewCell
        
        switch indexPath.row {
        case 0:
            let title = "Wind Speed"
            let value = viewDataItem.windSpeed
            cell.configureCell(title: title, value: value)
            
        case 1:
            let title = "Pressure"
            let value = viewDataItem.pressure
            cell.configureCell(title: title, value: value)
            
        case 2:
            let title = "Humudity"
            let value = viewDataItem.humidity
            cell.configureCell(title: title, value: value)
            
        case 3:
            let title = "Wind Degree"
            let value = viewDataItem.windDegree
            cell.configureCell(title: title, value: value)
            
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2  , height:  collectionView.frame.size.height/2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
   }
    
    
    func configureCell(with item: ListViewDataModel) {        
       viewDataItem = item
        self.labelDegree.text = viewDataItem.degree
        self.labelDayName.text = item.dayName
        self.iconImage.image = UIImage(systemName: item.icon)
        self.collectionViewDays.reloadData()
    }
    
}
