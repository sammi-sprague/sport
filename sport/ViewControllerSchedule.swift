//
//  ViewControllerSchedule.swift
//  sport
//
//  Created by SAMANTHA SPRAGUE on 2/8/23.
//

import UIKit

class ViewControllerSchedule: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    
    @IBOutlet weak var tbv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbv.delegate = self
        tbv.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCellSubclass
        cell.configure(e: AppData.events[indexPath.row])
        return cell
        
        
    }
    
}
