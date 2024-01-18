//
//  HomeWatchItemCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/03.
//

import UIKit

class HomeRecentWatchItemCell: UICollectionViewCell {
    
    static let identifier: String = "HomeRecentWatchItemCell"

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    // 왜 static으로 선언했을까??
    /*
     DateFormatter는 생성비용이 큼
     따라서 반복사용의 여지가 있다면 static으로 선언해 하나만 생성해서 사용하는것도 좋다!!
     */
    private var imageTask: Task<Void, Never>?
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYMMDD"
        
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.thumbnailImageView.layer.cornerRadius = 42
        self.thumbnailImageView.layer.borderWidth = 2
        self.thumbnailImageView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageTask?.cancel()
        self.imageTask = nil
        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.dateLabel.text = nil
    }

    func setData(_ data: Home.Recent) {
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.channel
        // dateFormatter 앞에 대문자 Self 가 붙는데 이거 다시 찾아보기
        self.dateLabel.text = Self.dateFormatter.string(from: .init(timeIntervalSince1970: data.timeStamp))
        self.imageTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
    }
}
