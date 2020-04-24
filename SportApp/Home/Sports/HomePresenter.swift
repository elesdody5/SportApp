//
//  HomePresenter.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
@available(iOS 13.0, *)
class HomePresenter: HomePresenterProtcol {
   
    weak private var HomeView: HomeViewController?
    private let handler: Network
    var SportsList = [Sport]()
//_______________________________________________
    @available(iOS 13.0, *)
    func attachView(view: HomeViewController) {
        HomeView = view
    }
    func detachView() {
          HomeView=nil
    }
    
    init(handler : Network) {
           self.handler = handler
       }
    func isReachable()-> Bool{
        return  Reachability.isConnectedToNetwork()
    }
    
    func getSportsList() {
        
        if  isReachable(){
        
            HomeView?.indicator(Status: true)
            handler.getSports(callBack:{[weak self] Sports in
    
            if Sports.count > 0 {
              self?.HomeView?.indicator(Status: false)
                  self?.SportsList=Sports
                  self?.HomeView?.updateUI()
            
            }
            else{ self?.HomeView?.updateUI()}
            
    })
        }
        
    }
    
}

//_______________________________________________***
struct Sport{
    let sportName:String
    let sportsImgPath:String
    
}
