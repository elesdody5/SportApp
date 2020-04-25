//
//  LeagueCell.swift
//  SportApp
//
//  Created by Omnia on 4/23/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import Foundation
import UIKit
class LeaguesTableViewCell:UITableViewCell{
   var youTubeLink:String?
    @IBOutlet weak var leaguepic: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var watchURL: UIButton!

    @IBAction func WatchAction(_ sender: Any) {
           guard let url = URL(string: youTubeLink!) else {
               return //be safe
           }
           
           if #available(iOS 10.0, *) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       }
    
}
