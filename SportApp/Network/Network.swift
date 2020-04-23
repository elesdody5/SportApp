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
    let leaguesURL: String="https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s="//?
    let LeagueDetailsURL : String="https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="
    let teamsURL : String="https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id="
    let teamDetailsurl:String="https://www.thesportsdb.com/api/v1/json/1/lookupteam.php?id="
    let teamEventUrl:String = "https://www.thesportsdb.com/api/v1/json/1/eventsnext.php?id="
    let LeaguesEventURL:String="https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    
    var sportsResult=[Sport]()
    var leaguesResult=[League]()
    var leaguesTeams=[Team]()
    var leagueEvents=[Event]()
    var leagueResults=[Event]()
    
    var eventsResult=[Any]()

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
                self.sportsResult.removeAll()
              }
          }catch{
          }
          }).resume()
          }

    func getLeagues(sportname:String,callBack:@escaping ([League]) -> Void){
            let url=URL(string: leaguesURL+sportname)
            let request = URLRequest(url: sportsURL!)
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
             
            let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
                
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as!Dictionary<String,Array<Dictionary<String,Any>>>
               if json != nil {
                let resLeagues:Array<Dictionary<String,Any>> = json["countrys"]!
               
                for i in 0...json.count-1 {
                    var dict = resLeagues[i]
                    var id:String = dict["idLeague"] as! String
                    self.leaguesResult.append(League(id: Int(id)!, name: dict["strLeague"] as! String, sport: dict["strSport"] as! String, leagueAlternate: dict["strLeagueAlternate"] as! String, logoUrl: dict["strBadge"] as! String, youTubeUrl: dict["strYoutube"] as! String))
                    print(self.leaguesResult.count)

                }
                }
                DispatchQueue.main.async {
                
                 callBack(self.leaguesResult)
                    self.leaguesResult.removeAll()
                }
            }catch{
            }
            }).resume()
            }
    
    func getLeagueDetails(leagueID:Int,callBack:@escaping (League) -> Void){
        let url=URL(string: LeagueDetailsURL+String(leagueID))
            let request = URLRequest(url: sportsURL!)
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
             
            let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
                
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as!Dictionary<String,Dictionary<String,Any>>
                
                let loaded:Dictionary<String,Any> = json["leagues"]!
                    
                let loadedLeague:League = League(id:loaded["idLeague"] as! Int,name:loaded["strLeague"] as! String,sport:loaded["strSport"] as! String,leagueAlternate:loaded["strLeagueAlternate"] as! String,logoUrl:loaded["strLogo"] as! String,youTubeUrl:loaded["strYoutube"] as! String)
            
                
               ////change
                DispatchQueue.main.async {
                 callBack(loadedLeague)
                  
                }
            }catch{
            }
            }).resume()
            }
  
    func getLeagueTeams(leagueId:Int,callBack:@escaping ([Team]) -> Void){
        let url=URL(string: teamsURL+"\(leagueId)")
             let request = URLRequest(url: sportsURL!)
             
             let session = URLSession(configuration: URLSessionConfiguration.default)
              
             let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
                 
             do{
                 let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String,Array<Dictionary<String,Any>>>
                            
                    if json != nil {
                      let dicts:Array<Dictionary<String,Any>> = json["teams"]!
                        print("teaaaaammmmsssssssss\(dicts.count)")
                    for i in 0...dicts.count-1 {
                        var dict = dicts[i]
                        self.leaguesTeams.append(Team(id: dict["idTeam"] as! String , name: dict["strTeam"] as! String, league: dict["strLeague"] as! String , manager: dict["strManager"] as! String, logoUrl: dict["strTeamBadge"]! as! String ))
                                }}
                 DispatchQueue.main.async {
                    callBack(self.leaguesTeams)
                    self.leaguesTeams.removeAll()
                 }
             }catch{
             }
             }).resume()
             }
    
    
    
    func getTeamDetails(id:String,loadTeam:@escaping (_ team:Team)->Void) {
        let url=URL(string: teamDetailsurl+id)
        let request  = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request){
            (data,response,error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as!Dictionary<String,Any>
                let teams = json["teams"] as!Array<Dictionary<String,Any>>
                let jsonTeam = teams[0]
                DispatchQueue.main.async {
                    loadTeam(Team(id: id, name: jsonTeam["strTeam"] as! String, league: jsonTeam["strLeague"] as! String, manager: jsonTeam["strManager"] as! String, logoUrl: jsonTeam["strTeamBadge"] as! String))
                }
            }catch{
                print(error)
            }
        }.resume()
    }
    func getTeamEvents(teamId:String,loadTeamEvents:@escaping (_ events:Array<Event>)->Void) {
        let url=URL(string: teamEventUrl+teamId)
        let request  = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request){
            (data,response,error) in
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as!Dictionary<String,Any>
                let jsonEvents = json["events"] as!Array<Dictionary<String,Any>>
                var events=Array<Event>()
                for jsonEvent in jsonEvents{
                    var homeScore = jsonEvent["intHomeScore"]as?Int
                    
                    var awayScore = jsonEvent["intawayScore"]as?Int
                    
                    events.append(Event(id: jsonEvent["idEvent"]as!String, name: jsonEvent["strEvent"] as! String, homeTeam: jsonEvent["strHomeTeam"] as! String, awayTeam: jsonEvent["strAwayTeam"]as! String , homeScore: homeScore ?? 0, awayScore: awayScore ?? 0))
                }
                DispatchQueue.main.async {
                    loadTeamEvents(events)
                }
            }catch{
                print(error)
            }
            }.resume()
    }
    
    
    func getLeagueEvents(leagueid:String, callBack:@escaping ([Event])->Void) {
      
        let url=URL(string: LeaguesEventURL + "\(leagueid)")
        let request = URLRequest(url: sportsURL!)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
         
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            
        do{
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String,Array<Dictionary<String,Any>>>
                       
               if json != nil {
                 let dicts:Array<Dictionary<String,Any>> = json["events"]!
                       
               for i in 0...dicts.count-1 {
                   var dict = dicts[i]
                 var score1:String?
                 var score2:String?
                if let score:String = dict["intHomeScore"] as! String,let score3:String = dict["intAwayScore"] as! String{
                  score1 = dict["intHomeScore"] as! String ?? " "
                   score2 = dict["intAwayScore"] as! String ?? " "}
                self.leagueEvents.append(Event(id: dict["idEvent"] as! String, name: dict["strEvent"] as! String, homeTeam: dict["strHomeTeam"] as! String, awayTeam: dict["strAwayTeam"] as! String, homeScore:Int((score1!)) ?? 0, awayScore:Int(score2!) ?? 0 ))
                           }}
            DispatchQueue.main.async {
               callBack(self.leagueEvents)
                self.leagueEvents.removeAll()
            }
        }catch{
        }
        }).resume()
        
    }
    
    
    func getLeagueResults(leagueid:String, callBack:@escaping ([Event])->Void) {
       
         let url=URL(string: LeaguesEventURL + "\(leagueid)")
         let request = URLRequest(url: sportsURL!)
         
         let session = URLSession(configuration: URLSessionConfiguration.default)
          
         let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
             
         do{
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String,Array<Dictionary<String,Any>>>
                        
              if json != nil {
                  let dicts:Array<Dictionary<String,Any>> = json["events"]!
                        
                for i in 0...dicts.count-1 {
                    var dict = dicts[i]
                  var score1:String?
                  var score2:String?
                if dict["intHomeScore"] != nil {
                score1 = dict["intHomeScore"] as! String ?? " "
                score2 = dict["intAwayScore"] as! String ?? " "}
                self.leagueResults.append(Event(id: dict["idEvent"] as! String, name: dict["strEvent"] as! String, homeTeam: dict["strHomeTeam"] as! String, awayTeam: dict["strAwayTeam"] as! String, homeScore:Int(score1!) ?? 0, awayScore:Int(score2!)as! Int ?? 0))
                            }}
             DispatchQueue.main.async {
                callBack(self.leagueResults)
                self.leagueResults.removeAll()
             
            }}catch{
         }
         }).resume()
         
     }
    
    

}










