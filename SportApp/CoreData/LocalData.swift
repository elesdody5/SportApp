//
//  LocalData4.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
import CoreData
class CoreDataService {
    
var mangedConetxt:NSManagedObjectContext!
init(mangedConetxt:NSManagedObjectContext) {
        self.mangedConetxt = mangedConetxt
    }
    func fetchLeagueList()->Array<League>{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        
        do{
              let result =   try (mangedConetxt?.fetch(fetchRequest))!
            var leagues = Array<League>()
            for leagueEntity in result {
                leagues.append(League(id: leagueEntity.value(forKey: "id") as! Int, name: leagueEntity.value(forKey: "name") as! String, sport: leagueEntity.value(forKey: "sport") as! String, leagueAlternate: leagueEntity.value(forKey: "leagueAlternate") as! String))
            }
            return leagues
        }
        catch let error as NSError{
            print(error.localizedDescription)
            return Array<League>()
        }
    }
    func fetchLeagueWithId(id:Int)->NSManagedObject{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        
        do{
            return try (mangedConetxt?.fetch(fetchRequest))![0]
        }
        catch let error as NSError{
            print(error.localizedDescription)
            return NSManagedObject()
        }
    }
func insert(league:League)->Bool{
      let entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: mangedConetxt!)
    let leagueEntity = NSManagedObject(entity: entity!, insertInto: mangedConetxt)

    leagueEntity.setValue(league.id, forKey: "id")
    leagueEntity.setValue(league.name, forKey: "name")
    leagueEntity.setValue(league.sport, forKey: "sport")
    leagueEntity.setValue(league.leagueAlternate, forKey: "leagueAlternate")


    do{
        try mangedConetxt!.save()
        return true
    }
    catch let error as NSError{
        print(error.description)
        return false
    }
}
    func deletLeague(id:Int) {
        mangedConetxt.delete(fetchLeagueWithId(id:id))
        do{
            try mangedConetxt!.save()
        }
        catch let error as NSError{
            print(error.description)
        }
    }
}
