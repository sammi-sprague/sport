//
//  GameResults.swift
//  sport
//
//  Created by SAMANTHA SPRAGUE on 2/21/23.
//

import UIKit

class GameResults: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tbv: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbv.delegate = self
        tbv.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tbv.reloadData()
        print("appear")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AppData.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "CLC \(AppData.games[indexPath.row].scoreCLC) vs \(AppData.games[indexPath.row].scoreOpp) \(AppData.games[indexPath.row].opp)"
               return cell
        
    }
    


}
