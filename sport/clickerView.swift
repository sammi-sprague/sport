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
        }
    }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return things.count
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
