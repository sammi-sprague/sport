//
//  clickerView.swift
//  sport
//
//  Created by ALEXANDER CARLSON on 2/14/23.
//

import UIKit

class clickerView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if component == 0{
                return things[row]
            }else{
                return things2[row]
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0{
                print(things[row])
            }else{
                print(things2[row])
     }
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if component == 0{
                return things.count
            }else{
                return things2.count
            }

        }
        
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
