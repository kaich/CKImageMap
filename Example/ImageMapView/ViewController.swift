//
//  ViewController.swift
//  ImageMapView
//
//  Created by kai on 12/01/2017.
//  Copyright (c) 2017 kai. All rights reserved.
//

import UIKit
import CKImageMap

class ViewController: UIViewController {
    var mapView = CKImageMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.imageURL = Bundle.main.url(forResource: "timg", withExtension: "jpeg")
        mapView.mapName = "testMarker"
        var markers = [CKMapMarker]()
        let imgStr = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512487800561&di=d7c01133cfab9f18f8ce0da075c71f13&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fd62a6059252dd42a80d5ab97083b5bb5c9eab82a.jpg"
        let markedimgStr = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1513078883283&di=23f785ff1e279de89e8dbf8efbadfaa2&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F80cb39dbb6fd5266fb94af28a018972bd407364a.jpg"
        for index in 1...20 {
            let marker = CKMapMarker(point: CGPoint(x: Int(arc4random_uniform(1100)), y: Int(arc4random_uniform(700))),imageURL: URL(string: imgStr), markedImageURL: URL(string: markedimgStr),title: String(index), message: "The arrow is centered by default, and moves to avoid the edge of the screen.")
            markers.append(marker)
        }
        let marker = CKMapMarker(point: CGPoint(x: 50, y: 50),imageURL: URL(string: imgStr), markedImageURL: URL(string: markedimgStr),title: "fixed", message: "The arrow is centered by default, and moves to avoid the edge of the screen.")
        markers.append(marker)
        
        mapView.markers = markers
        mapView.frame = self.view.bounds
        mapView.clickAnnotationBlock = { marker in
            let actionSheetController = UIAlertController(title: "Please select", message: "How you would like to utilize the app?", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                // Just dismiss the action sheet
            }
            actionSheetController.addAction(cancelAction)
            
            let markTitle = self.mapView.checkMarked(marker!) ? "unmark" : "mark"
            let takePictureAction = UIAlertAction(title: markTitle, style: .default) { action -> Void in
                if let marker = marker {
                    if self.mapView.checkMarked(marker) {
                        _ = self.mapView.unmark(marker)
                    }
                    else {
                        _ = self.mapView.mark(marker)
                    }
                }
            }
            actionSheetController.addAction(takePictureAction)
            self.present(actionSheetController, animated: true, completion: nil)
        }
        view.addSubview(mapView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

