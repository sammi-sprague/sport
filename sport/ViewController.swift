//
//  ViewController.swift
//  sport
//
//  Created by SAMANTHA SPRAGUE on 2/8/23.
//

import UIKit

class AppData{
    static var events = [Events(date: "Feb 2, 4:30", type: "Game", here: true, opp: "CLS", loc: "CLC", scoreCLC: 0, scoreOpp: 0)]
    static var selected = events[0]
    static var games = [events[0]]
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
}



class Events: Codable{
    
    var date: String
    var type: String
    var here: Bool
    var opp: String
    var loc: String
    var scoreCLC: Int
    var scoreOpp: Int
    
    init(date: String, type: String, here: Bool, opp: String, loc: String, scoreCLC: Int, scoreOpp: Int){
        self.date = "date"
        self.type = type
        self.here = here
        self.opp = opp
        self.loc = loc
        self.scoreCLC = 0
        self.scoreOpp = 0
    }
    
    func setScores(scoreHome: Int, scoreOpp: Int){
        self.scoreCLC = scoreHome
        self.scoreOpp = scoreOpp
    }
}
