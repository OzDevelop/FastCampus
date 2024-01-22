//
//  HomeViewModel.swift
//  KTV
//
//  Created by Lecture on 2023/09/08.
//

import Foundation

@MainActor class HomeViewModel {
    private(set) var home: Home?
    let recommendViewModel: HomeRecommendViewModel = .init()
    var dataChanged: (() -> Void)?
    
    func requestData() {
//        guard let jsonUrl = Bundle.main.url(forResource: "home", withExtension: "json") else {
//            print("resource not found")
//            return
//        }
//        
//        let jsonDecoder = JSONDecoder()
//        do {
//            let data = try Data(contentsOf: jsonUrl)
//            let home = try jsonDecoder.decode(Home.self, from: data)
//            self.home = home
//            self.dataChanged?()
//        } catch {
//            print("json parsing failed:  \(error.localizedDescription)")
//        }
        
        
        Task {
            do {
                self.home = try await DataLoader.load(url: URLDefines.home, for: Home.self)
                self.home = home
                self.recommendViewModel.recommends = home?.recommends
                self.dataChanged?()
            } catch {
                print("json parsing failed: \(error.localizedDescription)")
            }
        }
    }
}
