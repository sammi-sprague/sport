//
//  AddScore.swift
//  sport
//
//  Created by ALEXANDER CARLSON on 2/22/23.
//

import UIKit

class AddScore: UIViewController {

    
    var homeScore = 0
    var awayScore = 0
    

    @IBOutlet weak var homeScoreOutlet: UILabel!
    
    @IBOutlet weak var awayScoreOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func homeAddAction(_ sender: Any) {
        homeScore += 1
        homeScoreOutlet.text = "\(homeScore)"
    }
    
    @IBAction func homeRemoveAction(_ sender: Any) {
        if homeScore > 0 {
            homeScore -= 1
            homeScoreOutlet.text = "\(homeScore)"
        }
    }
    
    @IBAction func awayAddAction(_ sender: Any) {
        awayScore += 1
        awayScoreOutlet.text = "\(awayScore)"
    }
    
    @IBAction func awayRemoveAction(_ sender: Any) {
        if awayScore > 0 {
            awayScore -= 1
            awayScoreOutlet.text = "\(awayScore)"
        }
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
        AppData.selected.setScores(scoreHome: homeScore, scoreOpp: awayScore)
        
        homeScoreOutlet.text = "\(homeScore)"
        awayScoreOutlet.text = "\(awayScore)"
        AppData.events.remove(at: AppData.index)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
