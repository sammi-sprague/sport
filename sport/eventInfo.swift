//
//  eventInfo.swift
//  sport
//
//  Created by ALEXANDER CARLSON on 2/13/23.
//

import UIKit
import MapKit

class eventInfo: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var locOutlet: UITextField!
    @IBOutlet weak var dateOutlet: UITextField!
    @IBOutlet weak var oppOutlet: UITextField!
    @IBOutlet weak var eventOutlet: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventOutlet.text = AppData.selected.type
        dateOutlet.text = AppData.selected.date
        oppOutlet.text = AppData.selected.opp
        if AppData.selected.here{
            locOutlet.text = "(H) "
        }else{
            locOutlet.text = "(A) "
        }
        locOutlet.text! += AppData.selected.loc
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
