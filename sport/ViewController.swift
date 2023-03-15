//
//  ViewController.swift
//  sport
//
//  Created by SAMANTHA SPRAGUE on 2/8/23.
//


//make a coco touch for new vc
//make an outlet and action for button to new vc



import UIKit
import FirebaseCore
import FirebaseDatabase


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
    var ref: DatabaseReference!
    @IBOutlet weak var tableViewOutlet: UITableView!
    var today = [Events]()
    var last = Events(date: "", type: "", here: true, opp: "", loc: "", d: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AppData.games.append(Events(date: "Feb 2, 4:30", type: "Game", here: true, opp: "CLS", loc: "CLC", d: Date()))
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        
        ref.child("list").observe(.childAdded){ snapshot in
            let dict = snapshot.value as! [String: Any]
            var it = Events(dict: dict)
            it.key = snapshot.key
            if !(self.last.equals(i: it)){
                AppData.events.append(it)
                self.tableViewOutlet.reloadData()
            }
        }
        
        ref.child("list").observe(.childRemoved){ snapshot in
            var k = snapshot.key
            for var i in 0..<AppData.events.count{
                if AppData.events[i].key == k{
                    AppData.events.remove(at: i)
                    self.tableViewOutlet.reloadData()
                    break
                }
            }
        }

        var cal = Calendar.current
        for ok in AppData.games{
            if cal.component(.day, from: ok.cDate) == cal.component(.day, from: Date()) && cal.component(.month, from: ok.cDate) == cal.component(.month, from: Date()){
                today.append(ok)
            }
        }
        
//        if let items = UserDefaults.standard.data(forKey: "myEvents") {
//            let decoder = JSONDecoder()
//            if let decoded = try? decoder.decode([Events].self, from: items) {
//                AppData.events = decoded
//            }
//        }
        ref = Database.database().reference()
        
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



class Events{
    
    var date: String
    var type: String
    var here: Bool
    var opp: String
    var loc: String
    var scoreCLC: Int
    var scoreOpp: Int
    var cDate: Date
    var key = ""
    var ref = Database.database().reference()
    
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
    
    init(dict: [String: Any]){
        if let n = dict["type"] as? String{
            type = n
        }
        if let a = dict["date"] as? String{
            date = a
        }
        if let b = dict["here"] as? Bool{
            here = b
        }
        if let c = dict["opp"] as? String{
            opp = c
        }
        if let f = dict["loc"] as? String{
            loc = f
        }
        if let e = dict["d"] as? Date{
            cDate = e
        }
    }
    
    
    func setScores(scoreHome: Int, scoreOpp: Int){
        self.scoreCLC = scoreHome
        self.scoreOpp = scoreOpp
        print("method")
        print(self.scoreOpp)
        print(self.scoreCLC)
    }
    
    func saveToFirebase(){
        var dict = ["type": type, "date": date, "here": here, "opp": opp, "loc": loc, "d": cDate] as [String: Any]
        key = ref.child("list").childByAutoId().key ?? "0"
        ref.child("list").child(key).setValue(dict)
    }
    
    func deleteFromFirebase(){
        ref.child("list").child(key).removeValue()
    }
    
    func equals(i: Events)-> Bool{
        if type == i.type && date == i.date && here == i.here && opp == i.opp && loc == i.loc && cDate == i.cDate{
            return true
        }
        return false
    }

}
