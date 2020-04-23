//
//  LeaguesContract.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
protocol LeaguesPresenterProtocol {
    func getLeagues()
     var Leagues:Array<League> { get set }
}
protocol LeaguesViewProtocol {
   
    func updateLeagues()
    func indicator(Status:Bool)

     func gotoSportLeagues(sport:String)
    
}
