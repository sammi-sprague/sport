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
    
    override func viewWillAppear(_ animated: Bool) {
        tbv.reloadData()
        print("view appearing")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddSegue"{
            let nvc = segue.destination as! clickerView
            nvc.vc = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCellSubclass
        cell.configure(e: AppData.events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppData.selected = AppData.events[indexPath.row]
        AppData.index = indexPath.row
        print(AppData.selected.type)
        self.performSegue(withIdentifier: "toDetailSegue", sender: self)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
        
    }
    
}
