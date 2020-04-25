//
//  LeaguePresenter.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
class LeaguePresenter: LeaguesPresenterProtocol {
    
    weak private var LeaguesView: LeaguesViewController?
    private let handler: Network?
    let Sport:String
    var Leagues = [League]()
    
    init(Handler: Network,sport:String) {
        self.handler=Handler
        self.Sport=sport
    }
    func attachView(view: LeaguesViewController) {
        LeaguesView = view
    }
    func detachView() {
          LeaguesView=nil
    }
    func isreachable() ->Bool {
        return Reachability.isConnectedToNetwork()
    }
    
    func getLeagues() {
        if isreachable() { handler?.getLeagues(sportname:Sport,callBack:{[weak self] leagues in
           
        if leagues.count > 0 {
                 
        self?.Leagues=leagues
       
                  print("insideGetLeagues\(leagues.count)")

                  }
                   self?.LeaguesView!.updateLeagues()
        })
            
        }
       LeaguesView!.updateLeagues()
    }
    
  
    
    
}
