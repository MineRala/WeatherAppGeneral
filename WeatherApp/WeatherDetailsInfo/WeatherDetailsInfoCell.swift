//
//  WeatherDetailsInfoCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class WeatherDetailsInfoCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet private weak var collectionViewDetails: UICollectionView!
    var sunrise : UInt = 0
    var sunset : UInt = 0
    var seaLevel : Int = 0
    var grndLevel : Int = 0
    var windDegree: Int = 0
    var windSpeed : Double = 0.0
    var pressure : Int = 0
    var humudity : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewDetails.register(UINib(nibName: "WeatherDetailInfoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeatherDetailInfoCollectionCell")
        self.collectionViewDetails.delegate = self
        self.collectionViewDetails.dataSource = self
        self.collectionViewDetails.reloadData()

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailInfoCollectionCell", for: indexPath) as! WeatherDetailInfoCollectionCell
        
        switch indexPath.row {
        case 0:
            cell.configureCell(title: "sunrise", value: "\(sunrise)")
            
        case 1:
            cell.configureCell(title: "sunset", value: "\(sunset)")
        case 2:
            cell.configureCell(title: "sea Level", value: "\(seaLevel)")
        case 3:
            cell.configureCell(title: "grnd Level", value: "\(grndLevel)")
            
        default:
            break
        }
        
        return cell
    }
    
    func configureCell(sunset:UInt,sunrise:UInt,seaLevel:Int,grnLevel:Int){
        self.sunset = sunset
        self.sunrise = sunrise
        self.seaLevel = seaLevel
        self.grndLevel = grnLevel
    }
    
    func configureCell(windSpeed:Double,windDegree:Int,pressure:Int,humudity:Int){
        self.windSpeed = windSpeed
        self.windDegree = windDegree
        self.pressure = pressure
        self.humudity = humudity
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - 32, height: 84)
    }
    
    
}
