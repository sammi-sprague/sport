//
//  ViewController.swift
//  sport
//
//  Created by SAMANTHA SPRAGUE on 2/8/23.
//

import UIKit

class AppData{
    static var events = [Events(date: "Feb 2, 4:30", type: "Game", here: true, opp: "CLS", loc: "CLC")]
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
    
    init(date: String, type: String, here: Bool, opp: String, loc: String){
        self.date = date
        self.type = type
        self.here = here
        self.opp = opp
        self.loc = loc
    }
}
