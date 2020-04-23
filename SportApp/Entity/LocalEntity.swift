//
//  LocalEntity.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/19/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
struct League {
    var id:Int
    var name:String
    var sport:String
    var leagueAlternate:String
    var logoUrl:String
    var youTubeUrl:String
}

struct Results {
    var id :String
    var name:String
    var homeTeam:String
    var awayTeam:String
    var homeScore:Int
    var awayScore:Int
    var homeTeamID:Int
    var awayTeamID:Int
    
}

