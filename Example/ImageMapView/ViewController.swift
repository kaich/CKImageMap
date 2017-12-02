//
//  ViewController.swift
//  ImageMapView
//
//  Created by kai on 12/01/2017.
//  Copyright (c) 2017 kai. All rights reserved.
//

import UIKit
import ImageMapView

class ViewController: UIViewController {
    var mapView = CKImageMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var markers = [CKMapMarker]()
        for index in 1...20 {
            let marker = CKMapMarker(point: CGPoint(x: Int(arc4random_uniform(1100)), y: Int(arc4random_uniform(700))), title: String(index), message: "The arrow is centered by default, and moves to avoid the edge of the screen.")
            markers.append(marker)
        }
        mapView.markers = markers
        mapView.frame = self.view.bounds
        view.addSubview(mapView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

