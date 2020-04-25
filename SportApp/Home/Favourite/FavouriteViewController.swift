//
//  FavouriteViewController.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/17/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit
import CoreData
class FavouriteViewController: UITableViewController,FavouriteViewProtocol {
 
   
    @IBOutlet weak var NoFavoriteLeaguesView: UIImageView!
    @IBOutlet weak var NoConnectionView: UIView!
    var leagues = Array<League>()
    var presenter :FavouritePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        NoConnectionView.isHidden=true
       // NoFavoriteLeaguesView.isHidden=true
        
        let appDeleate:AppDelegate = (UIApplication.shared.delegate as!AppDelegate)
        let mangedConetxt:NSManagedObjectContext = appDeleate.persistentContainer.viewContext
        presenter = FaouritePresenter(view: self, mangedConetxt: mangedConetxt)
        presenter?.getFavouriteLeagues()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    func showEmptyState(){
        //self.tableView.isHidden = true
        NoFavoriteLeaguesView.isHidden = false

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavouriteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "favouritecell", for: indexPath) as! FavouriteTableViewCell
        let league = leagues[indexPath.row]
        let url = URL(string: league.logoUrl)
        cell.leageImage.kf.setImage(with: url)
        cell.leagueName.text = league.name
        cell.youTubeLink = league.youTubeUrl
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            presenter?.deleteLeague(id: leagues[indexPath.row].id)
            
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let league:LeagueDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailView") as! LeagueDetailsViewController
        if (presenter?.checkInternet())! {
        league.league = leagues[indexPath.row]
        self.navigationController?.pushViewController(league, animated: true)
        }
        else {
            showError()
        }
    }
    
    
    
    func displayList(leagues: Array<League>) {
        //self.tableView.isHidden = false
        NoFavoriteLeaguesView.isHidden = true

        self.leagues = leagues
        tableView.reloadData()
    }
    func showError(){
        let alert :UIAlertController=UIAlertController(title: "No Internet Connection", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
        self.present(alert, animated:  true,completion: nil)
        
    }
    
}
