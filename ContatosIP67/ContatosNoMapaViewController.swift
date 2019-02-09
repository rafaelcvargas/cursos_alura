//
//  ContatosNoMapaViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 2/8/19.
//  Copyright © 2019 vargas. All rights reserved.
//

import UIKit
import MapKit


class ContatosNoMapaViewController: UIViewController {

    @IBOutlet weak var mapa: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.locationManager.requestWhenInUseAuthorization()
        let botaoLocalizacao = MKUserTrackingBarButtonItem(mapView: self.mapa)
        self.navigationItem.rightBarButtonItem = botaoLocalizacao
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
