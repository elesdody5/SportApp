//
//  FavouriteContract.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
protocol FavouriteViewProtocol:AnyObject {
    func displayList(leagues:Array<League>)
    func showEmptyState()
}
protocol FavouritePresenterProtocol:AnyObject {
    func getFavouriteLeagues()
    func deleteLeague(id:Int)
    func checkInternet()->Bool
}
