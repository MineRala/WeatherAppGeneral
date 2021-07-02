//
//  WeatherDetailsInfoCell.swift
//  WeatherApp
//
//  Created by Mine Rala on 30.06.2021.
//

import UIKit

class WeatherDetailsInfoCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet private weak var collectionViewDetails: UICollectionView!
    
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2 - 32, height: 84)
    }
    
}
