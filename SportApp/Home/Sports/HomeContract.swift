//
//  HomeContract.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
protocol HomeViewProtcol {
    func indicator(Status:Bool)
    func updateUI()
    func nothingToDisplay(Status:Bool)
    func gotoSportLeagues(sport:String)
}
protocol HomePresenterProtcol {
    
    var SportsList:Array<Sport> { get set }
    func getSportsList()
    
}
