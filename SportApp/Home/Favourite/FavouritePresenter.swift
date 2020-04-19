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
        
    }
    func getFavouriteLeagues() {
      let leagues =  coreDataService?.fetchLeagueList()
        view.displayList(leagues: leagues!)
    }
    
    func deleteLeague(id: Int) {
        coreDataService?.deletLeague(id: id)
    }
    
    
}
