//
//  TeamDetailsPresenter.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
class TeamDeatailsPresenter: TeamDetailsPresenterProtocol {
    private weak var view:TeamDetailsViewProtocol!
    init(view:TeamDetailsViewProtocol) {
        self.view = view
    }
    func loadTeamDetails(id: String) {
        Network.getInstance().getTeamDetails(id: id, loadTeam: returnTeamResult(team:))
        loadTeamEvents(teamId: id)
    }
    
    func returnTeamResult(team:Team)  {
        view.displayTeamDetails(team: team)
    }
    func loadTeamEvents(teamId:String)  {
        Network.getInstance().getTeamEvents(teamId: teamId, loadTeamEvents: returnTeamEvents(events:))
        
    }
    func returnTeamEvents(events:Array<Event>) {
        view.displayTeamEvents(events: events)
    }
}
