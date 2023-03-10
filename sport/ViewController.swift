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
    static var announcements = [String]()
}

class CrazyCell: UITableViewCell{
    
    @IBOutlet weak var typeOutlet: UILabel!
    @IBOutlet weak var locOutlet: UILabel!
    @IBOutlet weak var timeOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(e: Events){
        
        typeOutlet.text = e.type
        if e.here{
            typeOutlet.text! += " (H)"
        }else{
            typeOutlet.text! += " (A)"
        }
        
        var cal =  Calendar.current
        let hour = cal.component(.hour, from: e.cDate)
        let min = cal.component(.minute, from: e.cDate)
        //print(hour)
        timeOutlet.text = "\(hour):\(min)"
        
        locOutlet.text = "@ \(e.loc)"
        
    }
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addAnnouncement: UITextField!
    @IBOutlet weak var aField: UITextView!
    
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    var today = [Events]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AppData.games.append(Events(date: "Feb 2, 4:30", type: "Game", here: true, opp: "CLS", loc: "CLC", d: Date()))
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self

        var cal = Calendar.current
        for ok in AppData.games{
            if cal.component(.day, from: ok.cDate) == cal.component(.day, from: Date()) && cal.component(.month, from: ok.cDate) == cal.component(.month, from: Date()){
                today.append(ok)
            }
        }
        
        if let items = UserDefaults.standard.data(forKey: "myEvents") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Events].self, from: items) {
                AppData.events = decoded
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        today.count
        
    }
    func addAnnouncement(_ sender: Any) {
        AppData.announcements.append(addAnnouncement.text!)
        for i in AppData.announcements{
            aField.text = i
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrazyCell") as! CrazyCell
        cell.configure(e: today[indexPath.row])
        return cell
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
        print("method")
        print(self.scoreOpp)
        print(self.scoreCLC)
    }
}
