//
//  FavouritePresenter.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
import CoreData

class FaouritePresenter: FavouritePresenterProtocol {
    private weak var view: FavouriteViewProtocol!
    private var coreDataService:CoreDataService?
    init(view: FavouriteViewProtocol,mangedConetxt:NSManagedObjectContext) {
        self.view = view
        coreDataService = CoreDataService(mangedConetxt: mangedConetxt)
       var league = League(id: 4328, name: "English Premier League", sport: "Soccer", leagueAlternate: "Premier League", logoUrl: "https://www.thesportsdb.com/images/media/league/logo/4c377s1535214890.png", youTubeUrl: "www.youtube.com/channel/UCG5qGWdu8nIRZqJ_GgDwQ-w")

        coreDataService?.insert(league: league)
        
    }
    func getFavouriteLeagues() {
        
            let leagues =  coreDataService?.fetchLeagueList()
            if leagues!.isEmpty {
                view.showEmptyState()
            }else{
                view.displayList(leagues: leagues!)
            }
        
    }
    
    func deleteLeague(id: Int) {
        coreDataService?.deletLeague(id: id)
    }
    func checkInternet() -> Bool {
        if Reachability.isConnectedToNetwork(){
            return true
        }else{
            return false
        }
    }
    
}
