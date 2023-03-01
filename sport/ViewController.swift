//
//  ViewController.swift
//  sport
//
//  Created by SAMANTHA SPRAGUE on 2/8/23.
//


//make a coco touch for new vc
//make an outlet and action for button to new vc



import UIKit

class AppData{
    static var events = [Events(date: "Feb 2, 4:30", type: "Game", here: true, opp: "CLS", loc: "CLC", d: Date())]
    static var selected = events[0]
    static var games = [Events]()
    static var index = 0
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AppData.games.append(Events(date: "Feb 2, 4:30", type: "Game", here: true, opp: "CLS", loc: "CLC", d: Date()))
        
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
    var cDate: Date
    
    init(date: String, type: String, here: Bool, opp: String, loc: String, d: Date){
        //self.date = "date" - A reminder of sammi's mistakes
        self.date = date
        self.type = type
        self.here = here
        self.opp = opp
        self.loc = loc
        self.scoreCLC = 0
        self.scoreOpp = 0
        self.cDate = d
    }
    
    func setScores(scoreHome: Int, scoreOpp: Int){
        self.scoreCLC = scoreHome
        self.scoreOpp = scoreOpp
    }
}
