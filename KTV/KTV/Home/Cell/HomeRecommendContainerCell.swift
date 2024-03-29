//
//  HomeRecommendContainerCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/08.
//

import UIKit

protocol HomeRecommendContainerCellDelegate: AnyObject {
    func homeRecommendContainerCell(_ cell: HomeRecommendContainerCell, didSelectItemAt index: Int)
    func homeRecommendContainerCellFoldChanged(_ cell: HomeRecommendContainerCell)
}

class HomeRecommendContainerCell: UICollectionViewCell {

    static let identifier: String = "HomeRecommendContainerCell"
    
    static func height(viewModel: HomeRecommendViewModel) -> CGFloat {
        let top: CGFloat = 84 - 6 // 첫번째 cell에서 bottom까지의 거리 - cell의 상단 여백
        let bottom: CGFloat = 68 - 6 // 마지막 cell첫번째 bottom까지의 거리 - cell의 하단 여백
        
//        let footerInset: CGFloat = 51 // container -> footer 까지의 여백
//        return HomeRecommendItemCell.height * CGFloat(viewModel.itemCount) + top + bottom + footerInset
        return HomeRecommendItemCell.height * CGFloat(viewModel.itemCount) + top + bottom
    }
    
    private var viewModel: HomeRecommendViewModel?
    
    weak var delegate: HomeRecommendContainerCellDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var foldButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        self.tableView.rowHeight = HomeRecommendItemCell.height
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(
            UINib(nibName: "HomeRecommendItemCell", bundle: .main),
            forCellReuseIdentifier: HomeRecommendItemCell.identifier
        )
    }

    @IBAction func foldButtonDidTap(_ sender: Any) {
        self.viewModel?.toggleFoldState()
        self.delegate?.homeRecommendContainerCellFoldChanged(self)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setViewModel(_ viewModel: HomeRecommendViewModel) {
        self.viewModel = viewModel
        self.setButtonImage(viewModel.isFolded)
        self.tableView.reloadData()
        viewModel.foldChanged = { [weak self] isFolded in
            self?.tableView.reloadData()
            self?.setButtonImage(isFolded)
            
        }
    }
    
    private func setButtonImage(_ isFolded: Bool) {
        let imageName:String = isFolded ? "unfold" : "fold"
        self.foldButton.setImage(UIImage(named: imageName), for: .normal)
        print("folded")
    
    }
    
    
    
}

extension HomeRecommendContainerCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.itemCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeRecommendItemCell.identifier, for: indexPath
        )
        
        if let cell = cell as? HomeRecommendItemCell,
           let data = self.viewModel?.recommends?[indexPath.row] {
            cell.setData(data, rank: indexPath.row + 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.homeRecommendContainerCell(self, didSelectItemAt: indexPath.row)
    }
}
