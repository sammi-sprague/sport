//
//  ViewController.swift
//  sport
//
//  Created by SAMANTHA SPRAGUE on 2/8/23.
//

import UIKit

class AppData{
    static var events = [Events]()
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AppData.events.append(Events(date: "Feb 2", type: true, here: true, opp: "CLS", loc: "CLC"))
    }
    
}



class Events: Codable{
    
    var date: String
    var type: Bool
    var here: Bool
    var opp: String
    var loc: String
    
    init(date: String, type: Bool, here: Bool, opp: String, loc: String){
        self.date = date
        self.type = type
        self.here = here
        self.opp = opp
        self.loc = loc
    }
}
