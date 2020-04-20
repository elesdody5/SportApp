//
//  Network.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
class Network{
   private static let network=Network()
   private init() {
        
    }
   static func getInstance()-> Network{
        return network
    }
    
    let sportsURL  = URL(string: "https://www.thesportsdb.com/api/v1/json/1/all_sports.php")
    let leaguesURL: String="https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=England&s=Soccer"//?
    let LeagueDetailsURL : String="https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="
    let teamsURL : String="https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id="
    let teamDetailsurl:String="https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id="
   
    
    var sportsResult=[Sport]()
    var leaguesResult=[Any]()
    var eventsResult=[Any]()
    var results=[Any]()
    var teamsResult=[Any]()
    
    func getSports(callBack:@escaping ([Sport]) -> Void){
          print("inside get sports")
          let request = URLRequest(url: sportsURL!)
          
          let session = URLSession(configuration: URLSessionConfiguration.default)
           
          let task = session.dataTask(with: sportsURL!, completionHandler: { (data, response, error) in
              
          do{
              let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String,Array<Dictionary<String,Any>>>
            
             if json != nil {
            let dicts:Array<Dictionary<String,Any>> = json["sports"]!
            
            for i in 0...dicts.count-1 {
                  var dict = dicts[i]
                  self.sportsResult.append(Sport(sportName: dict["strSport"]! as! String, sportsImgPath:dict["strSportThumb"]! as! String))
                 print("sports are: \(dict["strSport"]! as! String)")
                }}
              
              DispatchQueue.main.async {
                callBack(self.sportsResult)
              }
          }catch{
          }
          }).resume()
          }

    func getLeagues(sportname:String,callBack:@escaping ([Any]) -> Void){
            let url=URL(string: leaguesURL+sportname)
            let request = URLRequest(url: sportsURL!)
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
             
            let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
                
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as!Array<Dictionary<String,Any>>
                for i in 0...json.count-1 {
                    var dict = json[i]
                    self.leaguesResult.append(0)
                 
                }
                callBack(self.leaguesResult)
                DispatchQueue.main.async {
                }
            }catch{
            }
            }).resume()
            }
    
    func getLeagueDetails(leagueID:Int,callBack:@escaping ([Any]) -> Void){
        let url=URL(string: LeagueDetailsURL+String(leagueID))
            let request = URLRequest(url: sportsURL!)
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
             
            let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
                
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as!Array<Dictionary<String,Any>>
                for i in 0...json.count-1 {
                    var dict = json[i]
                    self.sportsResult.append(Sport(sportName: dict["sport"]! as! String, sportsImgPath:dict["thumbnail"]! as! String))
                 
                }
                callBack(self.sportsResult)////change
                DispatchQueue.main.async {
                }
            }catch{
            }
            }).resume()
            }
  
    func getLeagueTeams(leagueId:Int,callBack:@escaping ([Any]) -> Void){
        let url=URL(string: teamsURL+"\(leagueId)")
             let request = URLRequest(url: sportsURL!)
             
             let session = URLSession(configuration: URLSessionConfiguration.default)
              
             let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
                 
             do{
                 let json = try JSONSerialization.jsonObject(with: data!, options: []) as!Array<Dictionary<String,Any>>
                 for i in 0...json.count-1 {
                     var dict = json[i]
                     self.teamsResult.append(0)
                  
                 }
                 callBack(self.teamsResult)
                 DispatchQueue.main.async {
                 }
             }catch{
             }
             }).resume()
             }

}










