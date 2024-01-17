//
//  HomeRankingItemCell.swift
//  KTV
//
//  Created by 변상필 on 1/17/24.
//

import UIKit

class HomeRankingItemCell: UITableViewCell {

    static let identifier: String = "HomeRankingItemCell"
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
    }
    
    //cell 초기화, dequeueReusableCell의 문제점을 해결할 수 있음
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.numberLabel.text = nil
    }
    
    func setRank(_ rank: Int) {
        self.numberLabel.text = "\(rank)"
    }

    
}
