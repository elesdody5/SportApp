//
//  LeaguePresenter.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
class LeagueDetaislPresenter: LeagueDetailsPresenterProtocol {

    let myLeague:League
    var Results=[Event]()
    var Teams=[Team]()
    var Events=[Event]()
     weak private var leagueDetailView:LeagueDetailsViewController?
    private let handler: Network
   //------------------------------------------------------
    func attachView(view:LeagueDetailsViewController) {
            leagueDetailView = view
        }
    
    func detachView() {
            leagueDetailView=nil
        }
        

    init(handler : Network,league: League) {
               self.handler = handler
               self.myLeague = league
           }
        
    func isReachable()-> Bool{
       return  Reachability.isConnectedToNetwork()
    }

    func getResults() {
        if isReachable(){
        handler.getLeagueResults(leagueid:String(self.myLeague.id) , callBack:{[weak self] res in
            
                if res.count > 0 {
                   
                    self?.Results=res
                    self?.leagueDetailView?.ReloadResuts()
                    
                    }
                    
        })}
    }
    
    func getTeams() {
        if isReachable(){
        handler.getLeagueTeams(leagueId:self.myLeague.id, callBack:{[weak self] teams in
                   
                       if teams.count > 0 {
                          
                        self?.Teams = teams
                           self?.leagueDetailView?.reloadTeams()
                           
                           }
                           
        })}
    }
    
    func getEvents() {
        if isReachable(){
            
        handler.getLeagueEvents(leagueid:String(self.myLeague.id), callBack:{[weak self] events in
        
            if events.count > 0 {
               
             self?.Events = events
                self?.leagueDetailView?.reloadEvents()
                
                }
                
        })}
    }
    
        

}
