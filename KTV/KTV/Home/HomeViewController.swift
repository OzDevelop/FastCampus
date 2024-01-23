//
//  HomeViewController.swift
//  KTV
//
//  Created by Lecture on 2023/09/08.
//

import UIKit

class HomeViewController: UIViewController {

//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let homeViewModel: HomeViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.bindViewModel()
        self.homeViewModel.requestData()
    }
    
    private func setupTableView() {
        //  ** tableView를 이용할 경우 **
        
//        self.tableView.register(
//            UINib(nibName: "HomeHeaderView", bundle: .main),
//            forCellReuseIdentifier: HomeHeaderView.identifier
//        )
//        self.tableView.register(
//            UINib(nibName: "HomeVideoCell", bundle: .main),
//            forCellReuseIdentifier: HomeVideoCell.identifier
//        )
//        self.tableView.register(
//            UINib(nibName: "HomeRecommendContainerCell", bundle: .main),
//            forCellReuseIdentifier: HomeRecommendContainerCell.identifier
//        )
//        self.tableView.register(
//            UINib(nibName: "HomeFooterCell", bundle: .main),
//            forCellReuseIdentifier: HomeFooterCell.identifier
//        )
//        
//        //MARK: - Ranking 추가.
//        self.tableView.register(
//            UINib(nibName: HomeRankingContainerCell.identifier, bundle: nil),
//            forCellReuseIdentifier: HomeRankingContainerCell.identifier
//        )
//        
//        //MARK: - RecentWatch 추가
//        self.tableView.register(
//            UINib(nibName: HomeRecentWatchContainerCell.identifier, bundle: .main),
//            forCellReuseIdentifier: HomeRecentWatchContainerCell.identifier
//        )
//        
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty")
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        
//        self.tableView.isHidden = true
        
        // ** collectionView를 이용할 경우 **
        self.collectionView.register(
            UINib(nibName: "HomeHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.identifier
        )
        
        self.collectionView.register(
            UINib(nibName:"HomeRankingHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeRankingHeaderView.identifier
        )
        
        self.collectionView.register(
            UINib(nibName:"HomeFooterView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: HomeFooterView.identifier
        )
        
        self.collectionView.register(
            UINib(nibName: "HomeVideoCell", bundle: .main),
            forCellWithReuseIdentifier: HomeVideoCell.identifier
        )
        self.collectionView.register(
            UINib(nibName: "HomeRecommendContainerCell", bundle: .main),
            forCellWithReuseIdentifier: HomeRecommendContainerCell.identifier
        )
        self.collectionView.register(
            UINib(nibName: HomeRankingContainerCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: HomeRankingContainerCell.identifier
        )
        self.collectionView.register(
            UINib(nibName: HomeRecentWatchContainerCell.identifier, bundle: .main),
            forCellWithReuseIdentifier: HomeRecentWatchContainerCell.identifier
        )
        
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "empty")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.isHidden = true
        
    }
    
    //함 살펴보기
    private func bindViewModel() {
        self.homeViewModel.dataChanged = { [weak self] in
//            self?.tableView.isHidden = false
//            self?.tableView.reloadData()
            
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
        }
    } 
}

//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        HomeSection.allCases.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let section = HomeSection(rawValue: section) else {
//            return 0
//        }
//        switch section {
//        case .header:
//            return 1
//        case .video:
//            return self.homeViewModel.home?.videos.count ?? 0
//        case .ranking:
//            return 1
//        case .recentWatch:
//            return 1
//        case .recommend:
//            return 1
//        case .footer:
//            return 1
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let section = HomeSection(rawValue: indexPath.section) else {
//            return 0
//        }
//        switch section {
//        case .header:
//            return HomeHeaderView.height
//        case .video:
//            return HomeVideoCell.height
//        case .ranking:
//            return HomeRankingContainerCell.height
//        case .recentWatch:
//            return HomeRecentWatchContainerCell.height
//        case .recommend:
//            return HomeRecommendContainerCell.height(viewModel: self.homeViewModel.recommendViewModel)
//        case .footer:
//            return HomeFooterView.height
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let section = HomeSection(rawValue: indexPath.section) else {
//            return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
//        }
//        
//        switch section {
//        case .header:
//            return tableView.dequeueReusableCell(
//                withIdentifier: HomeHeaderView.identifier,
//                for: indexPath
//            )
//        case .video:
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: HomeVideoCell.identifier,
//                for: indexPath
//            )
//            
//            if
//                let cell = cell as? HomeVideoCell,
//                let data = self.homeViewModel.home?.videos[indexPath.row] {
//                cell.setData(data)
//            }
//            
//            return cell
//        case .ranking:
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: HomeRankingContainerCell.identifier,
//                for: indexPath
//            )
//            
//            if
//                let cell = cell as? HomeRankingContainerCell,
//                let data = self.homeViewModel.home?.rankings {
//                cell.setData(data)
//            }
//            
//            (cell as? HomeRankingContainerCell)?.delegate = self
//            
//            return cell
//        case .recentWatch:
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: HomeRecentWatchContainerCell.identifier,
//                for: indexPath
//            )
//            
//            if
//                let cell = cell as? HomeRecentWatchContainerCell,
//                let data = self.homeViewModel.home?.recents {
//                cell.delegate = self
//                cell.setData(data)
//            }
//            
//            return cell
//        case .recommend:
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: HomeRecommendContainerCell.identifier,
//                for: indexPath
//            )
//            
//            if let cell = cell as? HomeRecommendContainerCell {
//                cell.delegate = self
//                cell.setViewModel(self.homeViewModel.recommendViewModel)
//            }
//            
//            return cell
//        case .footer:
//            return tableView.dequeueReusableCell(
//                withIdentifier: HomeFooterView.identifier,
//                for: indexPath
//            )
//        }
//    }
//}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let section = HomeSection(rawValue: section) else {
            return .zero
        }
        
        switch section {
        case .header:
            return CGSize(width: collectionView.frame.width, height: HomeHeaderView.height)
        case .ranking:
            return CGSize(width: collectionView.frame.width, height: HomeRankingHeaderView.height)
        case .video, .recentWatch, .recommend, .footer:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let section = HomeSection(rawValue: section) else {
            return .zero
        }

        switch section {
        case .footer:
            return CGSize(width: collectionView.frame.width, height: HomeFooterView.height)
        case .header, .ranking, .video, .recentWatch, .recommend:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let section = HomeSection(rawValue: section) else {
            return .zero
        }
        
        return self.insetForSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let section = HomeSection(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .header, .footer:
            return 0
        case .video, .ranking, .recentWatch, .recommend:
            return 21
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return .zero
        }
        
        let inset = self.insetForSection(section)
        let width = collectionView.frame.width - inset.left - inset.right
        
        switch section {
        case .header, .footer:
            return .zero
        case .video:
            return .init(width: width, height: HomeVideoCell.height)
        case .ranking:
            return .init(width: width, height: HomeRankingContainerCell.height)
        case .recentWatch:
            return .init(width: width, height: HomeRecentWatchContainerCell.height)
        case .recommend:
            return .init(
                width: width,
                height: HomeRecommendContainerCell.height(viewModel: self.homeViewModel.recommendViewModel)
            )
        }
    }
    
    private func insetForSection(_ section: HomeSection) -> UIEdgeInsets {
        switch section {
        case .header, .footer:
            return .zero
        case .video, .ranking, .recentWatch, .recommend:
            return .init(top: 0, left: 21, bottom: 21, right: 21)
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else {
            return 0
        }
        switch section {
        case .header:
            return 0
        case .video:
            return self.homeViewModel.home?.videos.count ?? 0
        case .ranking:
            return 1
        case .recentWatch:
            return 1
        case .recommend:
            return 1
        case .footer:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return .init()
        }
        switch section {
        case .header:
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeHeaderView.identifier,
                for: indexPath
            )
        case .ranking:
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeRankingHeaderView.identifier,
                for: indexPath
            )
        case .footer:
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeFooterView.identifier,
                for: indexPath
            )
        case .video, .recentWatch, .recommend:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "empty", for: indexPath)
        }
        
        switch section {
        case .header, .footer:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "empty",
                for: indexPath
            )
        case .video:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeVideoCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeVideoCell,
                let data = self.homeViewModel.home?.videos[indexPath.item] {
                cell.setData(data)
            }
            
            return cell
        case .ranking:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeRankingContainerCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeRankingContainerCell,
                let data = self.homeViewModel.home?.rankings {
                cell.setData(data)
            }
            
            (cell as? HomeRankingContainerCell)?.delegate = self
            
            return cell
        case .recentWatch:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeRecentWatchContainerCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeRecentWatchContainerCell,
                let data = self.homeViewModel.home?.recents {
                cell.delegate = self
                cell.setData(data)
            }
            
            return cell
        case .recommend:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeRecommendContainerCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeRecommendContainerCell {
                cell.delegate = self
                cell.setViewModel(self.homeViewModel.recommendViewModel)
            }
            
            return cell
        }
    }
}

extension HomeViewController: HomeRankingContainerCellDelegate {
    func homeRankingContainerCell(_ cell: HomeRankingContainerCell, didSelectItemAt index: Int) {
        print("home ranking did select at \(index)")
    }
}

extension HomeViewController: HomeRecommendContainerCellDelegate {
    func homeRecommendContainerCellFoldChanged(_ cell: HomeRecommendContainerCell) {
//        tableView.reloadData()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func homeRecommendContainerCell(_ cell: HomeRecommendContainerCell, didSelectItemAt index: Int) {
        print("home recommend cell did select item at \(index)")
    }
}

extension HomeViewController: HomeRecentWatchContainerCellDelegate {
    
    func homeRecentWatchContainerCell(_ cell: HomeRecentWatchContainerCell, didSelectItemAt index: Int) {
        print("home recent watch did select at \(index)")
    }
}
