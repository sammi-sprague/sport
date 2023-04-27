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
    
    var vc: ViewControllerSchedule!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewOutlet.delegate = self
        pickerViewOutlet.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
        dateFormatter.dateFormat = "MMM dd, h:mm a"
        let year = dateFormatter.string(from: dateOutlet.date)
        
        var clc = locationOutlet.text?.lowercased()
        var here = false
        
        if clc == "clc" || clc == "crystal lake central" || clc == "central" || clc == "home"{
            here = true
        }
        
        var e = Events(date: year, type: things[rowSpot], here: here, opp: opponentOutlet.text!, loc: locationOutlet.text!, d: dateOutlet.date)
        //AppData.events.append(e)
        print(AppData.events)
        
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(AppData.events) {
//            UserDefaults.standard.set(encoded, forKey: "myEvents")
//        }
        
        
        e.saveToFirebase()
        AppData.last = e
        AppData.events = AppData.events.sorted(by: {$0.cDate < $1.cDate})
        vc.tbv.reloadData()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("disappear")
        vc.tbv.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        performSegue(withIdentifier: "throwinItBack", sender: nil)
    }
    
}
