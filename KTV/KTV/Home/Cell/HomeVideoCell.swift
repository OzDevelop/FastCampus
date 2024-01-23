//
//  HomeVideoCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/08.
//

import UIKit

class HomeVideoCell: UICollectionViewCell {
    
    static let height: CGFloat = 300
    static let identifier: String = "HomeVideoCell"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelSubtitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var hotImageView: UIImageView!
    // 찾아보기
    private var thumbnailTask: Task<Void, Never>?
    private var channelThumbnailTask: Task<Void, Never>?

    // tableViewCell의 initializer
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        
        self.channelImageView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.thumbnailTask?.cancel()
        self.thumbnailTask = nil
        self.channelThumbnailTask?.cancel()
        self.channelThumbnailTask = nil
        
        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.channelTitleLabel.text = nil
        self.channelImageView.image = nil
        self.channelSubtitleLabel.text = nil
    }

    // 찾아보기
    // 원래는 tableViewCell이었지만 collectionViewCell로 바꾸면서 필요없어짐
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setData(_ data: Home.Video) {
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.subtitle
        self.channelTitleLabel.text = data.channel
        self.channelSubtitleLabel.text = data.channelDescription
        self.hotImageView.isHidden = !data.isHot
        self.thumbnailTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
        self.channelThumbnailTask = self.channelImageView.loadImage(url: data.channelThumbnailURL)
    
    }
    
    
}
