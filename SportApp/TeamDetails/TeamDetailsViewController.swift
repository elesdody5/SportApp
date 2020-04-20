//
//  TeamDetailsViewController.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController ,TeamDetailsViewProtocol{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
