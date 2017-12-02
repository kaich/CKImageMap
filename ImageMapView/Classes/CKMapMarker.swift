//
//  CKMapMarker.swift
//  ImageMapView
//
//  Created by mk on 2017/12/2.
//

import UIKit

public class CKMapMarker: NSObject {
    var point: CGPoint = CGPoint(x: 0, y: 0)
    var title = ""
    var message = ""
    var isMarked = false
    var actionTitles = [String]()
    
    public init(point: CGPoint, title: String = "", message: String = "", isMarked: Bool = false, actionTitles: [String] = []) {
        self.point = point
        self.title = title
        self.message = message
        self.isMarked = isMarked
        self.actionTitles = actionTitles
    }
}


class CKMapAnotationView: UIView {
    var clickBlock: ((CKMapAnotationView) -> ())?
    var marker: CKMapMarker?
    
    private let btnAnnotation = UIButton(type: UIButtonType.custom)
    
    init(marker: CKMapMarker) {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        self.marker = marker
        
        let image = UIImage()
        btnAnnotation.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        btnAnnotation.setImage(image, for: .normal)
        btnAnnotation.backgroundColor = UIColor.green
        btnAnnotation.addTarget(self, action: #selector(pressAnnotation), for: .touchUpInside)
        addSubview(btnAnnotation)
        
        
        self.center = marker.point
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressAnnotation() {
        if let clickBlock = clickBlock {
            clickBlock(self)
        }
    }
}
