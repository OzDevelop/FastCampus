//
//  HomeRecommendItemCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/08.
//

import UIKit

class HomeRecommendItemCell: UITableViewCell {
    
    static let height: CGFloat = 71
    static let identifier: String = "HomeRecommendItemCell"

    @IBOutlet weak var thumbnailContainerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var playTimeBGView: UIView!
    @IBOutlet weak var playTimeLabel: UILabel!
    
    private var imageTask: Task<Void, Never>?
    //찾아보기 이거랑 dateFormatter 차이
    private static let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second ]
        
        return formatter
    }()
    
    /*
     xib로 만든 UI가 클래스에 정상적으로 연동이 성공했을 시 호출
     기본적으로 View는 두 개의 initinalizer가 있음
     
     아래와 같이 한 쌍으로 이루어져 있음
     근데 #1 은 테이블 뷰의 경우이고 일반적인 View는 #3 과 같은 이니셜라이저임 (#2는 동일)
     
     # 1
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
     }
     
     # 2
     required init?(coder: NSCoder) {
         super.init(coder: coder)
     
         fatalError("init(coder:) has not been implemented")
     }
     
     # 3
     override init(frame: CGRect) {
        super.init(frame: frame)
     }
     
     1(3) 과 2 의 차이점은 진입점이 다름
     일반적으로 코드로 뷰를 생성한다면 init(frame:)으로 생성을 해야함.
     xib로 뷰를 생성한다면 init(corder:)를 타게 됨.
     근데 init(corder:)가 동작하는 시점에서는 Nib의 로드가 끝나지 않았기 때문에 UI data가 연동이 되어있지 않음 (확인 필요)
     
     따라서 awakeFromNim()에서 셀을 초기화하면될듯 (이미 모두 로드가 끝난 상태이므로)
     
     ------*** 근데 View Controller는 이야기가 또 다름 ***-------
     
     아까 xib로 view를 만들 경우에는 5번을 탄다고 말했음.
     근데 xib로 viewcontoller를 만들 경우는 또 4번을 탐
     
     # 4
     init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
         super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
     }

     # 5
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         fatalError("init(coder:) has not been implemented")
     }
     */
    override func awakeFromNib() {
        super.awakeFromNib()

        self.thumbnailContainerView.layer.cornerRadius = 5
        self.rankLabel.layer.cornerRadius = 5
        // 원하는 라운딩 처리가 정상적으로 동작하도록 추가
        self.rankLabel.clipsToBounds = true
        self.playTimeBGView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.thumbnailImageView.image = nil
        self.playTimeLabel.text = nil
        self.rankLabel.text = nil
    }
    
    func setData(_ data: Home.Recommend, rank: Int?) {
        self.rankLabel.isHidden = rank == nil
        if let rank {
            self.rankLabel.text = "\(rank)"
        }
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.channel
        self.playTimeLabel.text = Self.timeFormatter.string(from: data.playtime)
        self.imageTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
    }
    
}
