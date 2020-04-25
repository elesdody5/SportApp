//
//  LeagueDetailsViewController.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit
import CoreData

class LeagueDetailsViewController: UIViewController,LeagueDetailsViewProtocol,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var noConnectionView: UIView!
   
    var coredata:CoreDataService?
    
    
    func indicator(Status: Bool) {
        if Status {self.indicator.startAnimating()}
        else { self.indicator.stopAnimating()}
    }
    
    func gotoSTeamDetals(TeamId: String) {
        //
    }
    
    
    func reloadEvents() {
        EventsCollecView.reloadData()
    }
    
    func reloadTeams() {
        teamsCollectionView.reloadData()
    }
    
    func ReloadResuts() {
        resultsTableView.reloadData()
        
    }
   ////////////////////////////////////////////////////////////////////////////////////
    var presenter: LeagueDetaislPresenter?
          
    var league: League?
    var selectedTeam:Team?

    var indicator = UIActivityIndicatorView(style:.whiteLarge) ///////////////////////////////////////////////////////////////////////////////////
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == teamsCollectionView {
            return presenter?.Teams.count ?? 0
        }
        else{
            return presenter?.Events.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == teamsCollectionView {
            let res:Team=(presenter?.Teams[indexPath.row])!
            let teamCell:TeamsOfLeagueCell=collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueTeamCell", for: indexPath) as!TeamsOfLeagueCell
                teamCell.LeagueTeamName.text=res.name
            teamCell.picture.kf.setImage(with:URL(string:res.logoUrl))
            
        return teamCell
        }
        else{
            let res:Event=(presenter?.Events[indexPath.row])!
                       let eventCell:EventCell=collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueEventCell", for: indexPath) as!EventCell
            eventCell.eventTeam1.text=res.awayTeam
            eventCell.EventTeam2.text=res.homeTeam
                   return eventCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               let width=UIScreen.main.bounds.width
        
               if collectionView == teamsCollectionView {
                
                return CGSize(width: width/3, height: width/3)
                          
               }
               else{
                  
                    return CGSize(width: width/2, height: width/4)
               }
       
           
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
        if (presenter?.isReachable())!{if collectionView == teamsCollectionView {
                    
                    let teamsDetailsView: TeamDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "TeamView") as! TeamDetailsViewController
                          selectedTeam = presenter?.Teams[indexPath.row]
                   teamsDetailsView.id = selectedTeam?.id
                    navigationController?.pushViewController(teamsDetailsView, animated: true)
                         
                    
                    
                    
          }
       }
        else{
            noConnectionView.isHidden=false

        }
                 
          
           
       }
    ////////////////////////////////////////////////////////////////////////////////////
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.Results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let res:Event=(presenter?.Results[indexPath.row])!
        let resCell:ResultsCell = tableView.dequeueReusableCell(withIdentifier: "LeagueResults", for: indexPath) as! ResultsCell
        resCell.leagueTeam1.text=res.awayTeam
        resCell.leagueTeam1result.text=String(res.awayScore)
        resCell.leagueTeam2.text=res.homeTeam
        resCell.leagueTeam2result.text=String(res.homeScore)
        
        return resCell
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
        
    }
/////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        noConnectionView.isHidden=true

     let appDeleate:AppDelegate = (UIApplication.shared.delegate as!AppDelegate)
     
     let mangedConetxt:NSManagedObjectContext = appDeleate.persistentContainer.viewContext
         coredata = CoreDataService(mangedConetxt: mangedConetxt)
              
        self.LeagueName.text=league?.name
        presenter = LeagueDetaislPresenter(handler: Network.getInstance(), league: league!)
        presenter?.attachView(view: self)
        indicator.center = self.view.center
                   self.view.addSubview(indicator)
        teamsCollectionView.delegate=self
        teamsCollectionView.dataSource=self
        resultsTableView.delegate=self
        resultsTableView.dataSource=self
        
        EventsCollecView.delegate=self
        EventsCollecView.dataSource=self
        presenter?.attachView(view: self)
        presenter?.getTeams()
        presenter?.getEvents()
        presenter?.getResults()
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if (presenter?.isReachable())! {
            noConnectionView.isHidden=true
            reloadTeams()
            reloadEvents()
            ReloadResuts()
            
               }
        else{
            noConnectionView.isHidden=false
               }
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
*/
//
// override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier=="TeamView"{
//            var TeamDetailsView:TeamDetailsViewController=segue.destination as! TeamDetailsViewController
//
//           // TeamDetailsView
//
//        }
//    }
    

    @IBAction func addLeagueToFavorites(_ sender: Any) {
        coredata?.insert(league: league!)
        
    }
    @IBOutlet weak var LeagueName: UILabel!
    
    @IBOutlet weak var EventsCollecView: UICollectionView!
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
}
