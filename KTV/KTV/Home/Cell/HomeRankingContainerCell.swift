//
//  HomeRankingContainerCell.swift
//  KTV
//
//  Created by 변상필 on 1/17/24.
//

import UIKit

// delegate 부분 다시 살펴보고 공부
protocol HomeRankingContainerCellDelegate: AnyObject {
    func homeRankingContainerCell(_ cell: HomeRankingContainerCell, didSelectItemAt index: Int)
}

class HomeRankingContainerCell: UITableViewCell {
    
    static let identifier: String = "HomeRankingContainerCell"
    static let height: CGFloat = 349
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: HomeRankingContainerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // itemCell 등록
        self.collectionView.register(
            UINib(nibName: HomeRankingItemCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: HomeRankingItemCell.identifier
        )
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeRankingContainerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeRankingItemCell.identifier,
            for: indexPath
        )
        
        if let cell = cell as? HomeRankingItemCell {
            cell.setRank(indexPath.item + 1)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.homeRankingContainerCell(self, didSelectItemAt: indexPath.item)
    }
}
