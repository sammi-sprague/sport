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
    static var events = [Events]()
                         //(date: "Feb 2, 4:30", type: "Game", here: true, opp: "CLS", loc: "CLC", d: Date())]
    static var selected = events[0]
    static var games = [Events]()
    static var index = 0
    static var announcements = ""
    static var last = Events(date: "", type: "", here: true, opp: "", loc: "", d: Date())
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
        
        let cal =  Calendar.current
        let hour = cal.component(.hour, from: e.cDate)
        let min = cal.component(.minute, from: e.cDate)
        //print(hour)
        locOutlet.text = "\(hour):\(min)"
        
        timeOutlet.text = "@ \(e.loc)"
        
    }
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addAnnouncement: UITextField!
    @IBOutlet weak var aField: UITextView!
    var ref: DatabaseReference!
    @IBOutlet weak var tableViewOutlet: UITableView!
    var today = [Events]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //AppData.games.append(Events(date: "Feb 2, 4:30", type: "Game", here: true, opp: "CLS", loc: "CLC", d: Date()))
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        ref = Database.database().reference()
        
        ref.child("list").observe(.childAdded){ snapshot in
            let dict = snapshot.value as! [String: Any]
            let it = Events(dict: dict)
            it.key = snapshot.key
            if !(AppData.last.equals(i: it)){
                AppData.events.append(it)
                self.tableViewOutlet.reloadData()
            }
        }
        
        ref.child("list").observe(.childRemoved){ snapshot in
            let k = snapshot.key
            for i in 0..<AppData.events.count{
                if AppData.events[i].key == k{
                    AppData.events.remove(at: i)
                    self.tableViewOutlet.reloadData()
                    break
                }
            }
        }
        
        ref.child("scores").observe(.childAdded){ snapshot in
            let dict = snapshot.value as! [String: Any]
            let it = Events(dict: dict)
            it.key = snapshot.key
            if !(AppData.last.equals(i: it)){
                AppData.games.append(it)
                self.tableViewOutlet.reloadData()
            }
        }
        
        ref.child("scores").observe(.childRemoved){ snapshot in
            let k = snapshot.key
            for i in 0..<AppData.games.count{
                if AppData.games[i].key == k{
                    AppData.games.remove(at: i)
                    self.tableViewOutlet.reloadData()
                    break
                }
            }
        }
        
        
        let cal = Calendar.current
        for ok in AppData.events{
            if ok.type == "Game" && cal.component(.day, from: ok.cDate) == cal.component(.day, from: Date()) && cal.component(.month, from: ok.cDate) == cal.component(.month, from: Date()){
                today.append(ok)
            }
        }
        
//        if let items = UserDefaults.standard.data(forKey: "myEvents") {
//            let decoder = JSONDecoder()
//            if let decoded = try? decoder.decode([Events].self, from: items) {
//                AppData.events = decoded
//            }
//        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        today.count
        
    }
    
    
//    func addAnnouncement(_ sender: Any) {
//        AppData.announcements.append(addAnnouncement.text!)
//        for i in AppData.announcements{
//            aField.text = i
//        }
//    }
    
    
    @IBAction func addAnnouncementsAction(_ sender: Any) {
        //AppData.announcements += ("\n"+addAnnouncement.text!)
        AppData.announcements = (addAnnouncement.text! + "\n\n" + AppData.announcements)
        aField.text = AppData.announcements
        addAnnouncement.text = ""
    }

    @IBAction func clearAction(_ sender: Any) {
        AppData.announcements = ""
        aField.text = AppData.announcements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrazyCell") as! CrazyCell
        cell.configure(e: today[indexPath.row])
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ref.child("list").observe(.childRemoved){ snapshot in
            let k = snapshot.key
            for i in 0..<AppData.events.count{
                if AppData.events[i].key == k{
                    AppData.events.remove(at: i)
                    self.tableViewOutlet.reloadData()
                    break
                }
            }
        }
    }
    
}



class Events{
    
    var date: String
    var type: String
    var here: Bool
    var opp: String
    var loc: String
    var scoreCLC = 0
    var scoreOpp = 0
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
        self.cDate = d
    }
    
    init(dict: [String: Any]){
        
        if let e = dict["d"] as? String{
            let dateFormatter = ISO8601DateFormatter()
            cDate = dateFormatter.date(from: e)!
        }else{
            cDate = Date()
        }
        
        if let n = dict["type"] as? String{
            type = n
        }else{
            type = "Game"
        }
        if let a = dict["date"] as? String{
            date = a
        }else{
            date = "today"
        }
        if let b = dict["here"] as? Bool{
            here = b
        }else{
            here = true
        }
        if let c = dict["opp"] as? String{
            opp = c
        }else{
            opp = "cls"
        }
        if let f = dict["loc"] as? String{
            loc = f
        }else{
            loc = "here"
        }
        if let g = dict["hScore"] as? Int{
            scoreCLC = g
        }else{
            scoreCLC = 0
        }
        if let h = dict["aScore"] as? Int{
            scoreOpp = h
        }else{
            scoreOpp = 0
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let sDate = dateFormatter.string(from: cDate)
        
        var dict = ["type": type, "date": date, "here": here, "opp": opp, "loc": loc, "d": sDate] as [String: Any]
        
        key = ref.child("list").childByAutoId().key ?? "0"
        ref.child("list").child(key).setValue(dict)
        
    }
    
    func saveToFirebase2(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let sDate = dateFormatter.string(from: cDate)
        var dict = ["type": type, "date": date, "here": here, "opp": opp, "loc": loc, "d": sDate, "hScore": scoreCLC, "aScore": scoreOpp] as [String: Any]
        
        //key = ref.child("scores").child(key)
        ref.child("scores").child(key).setValue(dict)
    }
    
    func deleteFromFirebase(){
        ref.child("list").child(key).removeValue()
        print("delete from firebase")
        print(key)
        
    }
    
    func equals(i: Events)-> Bool{
        if type == i.type && date == i.date && here == i.here && opp == i.opp && loc == i.loc && cDate == i.cDate{
            return true
        }
        return false
    }

}
