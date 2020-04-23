//
//  LeagueDetailsContract.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
protocol LeagueDetailsViewProtocol {
    
    func reloadEvents()
    func reloadTeams()
    func ReloadResuts()
    func indicator(Status:Bool)
    func gotoSTeamDetals(TeamId:String)
    
}
protocol LeagueDetailsPresenterProtocol {
    func getResults()
    func getTeams()
    func getEvents()
}
