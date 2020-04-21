//
//  TeamDetailsContract.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
protocol TeamDetailsPresenterProtocol:AnyObject {
    func loadTeamDetails(id:String)
}
protocol TeamDetailsViewProtocol :AnyObject{
    func displayTeamDetails(team:Team)
    func displayTeamEvents(events:Array<Event>) 
}
