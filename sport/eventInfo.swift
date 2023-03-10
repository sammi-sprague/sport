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
    @IBOutlet weak var oppLabelOutlet: UILabel!
    @IBOutlet weak var gameScoreOutlet: UIButton!
    @IBOutlet weak var eventOutlet: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    var vc: ViewControllerSchedule!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var mapOutlet: MKMapView!
    let locMan = CLLocationManager()
    var currloc: CLLocation!
    var spots = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        oppOutlet.isHidden = false
        oppLabelOutlet.isHidden = false
        updateButton.isHidden = false

        var curDate = Date()
        if curDate < AppData.selected.cDate{
            updateButton.isHidden = true
        }
        
        eventOutlet.text = AppData.selected.type
        dateOutlet.text = AppData.selected.date
        oppOutlet.text = AppData.selected.opp
        if AppData.selected.type != "Game"{
            oppOutlet.isHidden = true
            oppLabelOutlet.isHidden = true
            updateButton.isHidden = true
        }
        if AppData.selected.here{
            locOutlet.text = "(H) "
        }else{
            locOutlet.text = "(A) "
        }
        locOutlet.text! += AppData.selected.loc
        
        locMan.delegate = self
        locMan.desiredAccuracy = kCLLocationAccuracyBest
        locMan.startUpdatingLocation()
        locMan.requestWhenInUseAuthorization()
        
        
    }
    
    
//    @IBAction func loadAction(_ sender: Any) {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = AppData.selected.loc
//        request.region = MKCoordinateRegion(center: currloc.coordinate, latitudinalMeters: 0.05, longitudinalMeters: 0.05)
//        let search = MKLocalSearch(request: request)
//
//        search.start { response, error in
//            guard let response = response else{return}
//            for i in response.mapItems{
//                self.spots.append(i)
//                let ann = MKPointAnnotation()
//                ann.coordinate = i.placemark.coordinate
//                ann.title = i.name
//                self.mapOutlet.addAnnotation(ann)
//            }
//        }
//    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currloc = locations[0]
    }
    
    
    @IBAction func updateScoreAction(_ sender: Any) {
        performSegue(withIdentifier: "toScoreSegue", sender: self)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("disappear")
        vc.tbv.reloadData()
    }

}
