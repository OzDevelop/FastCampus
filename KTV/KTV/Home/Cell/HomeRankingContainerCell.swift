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

class HomeRankingContainerCell: UICollectionViewCell {
    
    static let identifier: String = "HomeRankingContainerCell"
    static let height: CGFloat = 265
    
    weak var delegate: HomeRankingContainerCellDelegate?
    
    private var rankings: [Home.Ranking]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setData(_ data: [Home.Ranking]) {
        self.rankings = data
        // 받아온 데이터를 기준으로 collectionView 리로드
        self.collectionView.reloadData()
    }
    
}

extension HomeRankingContainerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.rankings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeRankingItemCell.identifier,
            for: indexPath
        )
        
        if let cell = cell as? HomeRankingItemCell,
           let data = self.rankings?[indexPath.item] {
            cell.setData(data, rank: indexPath.item + 1)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.homeRankingContainerCell(self, didSelectItemAt: indexPath.item)
    }
}
