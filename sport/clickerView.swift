//
//  clickerView.swift
//  sport
//
//  Created by ALEXANDER CARLSON on 2/14/23.
//

import UIKit

class clickerView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    @IBOutlet weak var dateOutlet: UIDatePicker!
    @IBOutlet weak var opponentOutlet: UITextField!
    @IBOutlet weak var locationOutlet: UITextField!
    @IBOutlet weak var pickerViewOutlet: UIPickerView!
    var things = ["Practice","Game","Team Bonding","Pasta Party"]
    var rowSpot = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewOutlet.delegate = self
        pickerViewOutlet.dataSource = self
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return things[row]
        
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            print(things[row])
            rowSpot = row
        }
    }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return things.count
    }

    @IBAction func addButtonAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy h:mm a"
        let year = dateFormatter.string(from: dateOutlet.date)
        AppData.events.append(Events(date: year, type: things[rowSpot], here: false, opp: opponentOutlet.text!, loc: locationOutlet.text!))
        print(AppData.events)

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
