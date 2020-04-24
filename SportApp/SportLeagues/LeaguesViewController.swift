//
//  LeaguesViewController.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit

class LeaguesViewController: UITableViewController,LeaguesViewProtocol {
   
    @IBOutlet weak var NoConnectionView: UIView!
    var presenter: LeaguePresenter?
    
    public var sportname:String?
    var selectedLeague:League?
    func indicator(Status: Bool) {
        //
    }
    
    func gotoSportLeagues(sport: String) {
        //
    }
    
////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        NoConnectionView.isHidden=true
        print(sportname ?? "no sportname!!")
        presenter=LeaguePresenter(Handler: Network.getInstance(), sport:sportname ?? " ")
        presenter?.attachView(view: self)
            presenter?.getLeagues()
             
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
            updateLeagues()
     
         
    }

    func updateLeagues() {
      if (presenter?.isreachable())!{
                 NoConnectionView.isHidden=true
                 tableView.reloadData()
             } else{
                 NoConnectionView.isHidden=false
             }
        
           
        
       
        
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print((presenter?.Leagues.count)!)
        return (presenter?.Leagues.count)!      }
      
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let res:League=(presenter?.Leagues[indexPath.row])!
        let cell :LeaguesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell") as! LeaguesTableViewCell
       
        cell.leagueName.text=res.leagueAlternate
        cell.leaguepic.kf.setImage(with:URL(string:res.logoUrl))
        
          return cell
      }
      
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 104
          
      }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (presenter?.isreachable())!{
        let leagueDetailsView: LeagueDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailView") as! LeagueDetailsViewController
          
          selectedLeague=presenter?.Leagues[indexPath.row]
             leagueDetailsView.league=selectedLeague
             navigationController?.pushViewController(leagueDetailsView, animated: true)
        }
        else{
            NoConnectionView.isHidden=false
        }
       
    }


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           if segue.identifier=="toLeagueDetails"{
//               var leagueDetailsView:LeagueDetailsViewController=segue.destination as! LeagueDetailsViewController
//               
//            leagueDetailsView.league=self.selectedLeague
//               
//           }
//       }

}
