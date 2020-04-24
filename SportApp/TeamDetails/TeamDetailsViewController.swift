//
//  TeamDetailsViewController.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit
import Kingfisher
class TeamDetailsViewController: UIViewController ,TeamDetailsViewProtocol,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var NoConnectionView: UIView!
    
    
    
   
    var id:String? = "133604"
    var presenter:TeamDetailsPresenterProtocol?
    var events:Array<Event> = []
    override func viewDidLoad() {
        NoConnectionView.isHidden=true
        super.viewDidLoad()
        EventsTableView.delegate = self
        EventsTableView.dataSource = self
        // Do any additional setup after loading the view.
        presenter = TeamDeatailsPresenter(view: self)
        presenter?.loadTeamDetails(id: id ?? "")
        
    }
    
 
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TeamEventCell = tableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath) as! TeamEventCell
        let event = events[indexPath.row]
        cell.team1Name.text = event.homeTeam
        cell.team2Name.text = event.awayTeam
        cell.team1Score.text = String(event.homeScore)
        cell.team2Score.text = String(event.awayScore)
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func displayTeamDetails(team: Team) {
        teamName.text = team.name
        let url = URL(string: team.logoUrl)
        TeamLogo.kf.setImage(with: url)
        LeagueName.text = team.league
        headCoachName.text = team.manager
    }
    
    func displayTeamEvents(events: Array<Event>) {
        nextEvent.text = events[0].name
        self.events = events
        EventsTableView.reloadData()
    }
    @IBOutlet weak var TeamLogo: UIImageView!
    
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var LeagueName: UILabel!
    
    @IBOutlet weak var nextEvent: UILabel!
  
    @IBOutlet weak var headCoachpicture: UIImageView!
    
    @IBOutlet weak var headCoachName: UILabel!
    
    @IBOutlet weak var PlayersCollectionView: UICollectionView!
    
    @IBOutlet weak var EventsTableView: UITableView!
}

//eventCell Identifier = Event
//player cell Identifier= Player
//storyboard IDs:
//TeamView
//LeagueDetailView
//LeaguesView
