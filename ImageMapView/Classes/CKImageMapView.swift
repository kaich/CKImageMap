//
//  CKImageMapView.swift
//  ImageMapView
//
//  Created by mk on 2017/12/1.
//

import UIKit
import AMPopTip

public class CKImageMapView: UIView {
    let scrollView = UIScrollView()
    let ivMap = UIImageView()
    public var markers: [CKMapMarker] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    private var mapImage: UIImage?
    private var isInitialScaled = false //处理开始frame大小为0的情况
    private let popTip = PopTip()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mapImage = UIImage(named: "timg.jpeg")
        
        scrollView.delegate = self
        scrollView.contentSize = mapSize()
        addSubview(scrollView)

        ivMap.image = mapImage
        ivMap.isUserInteractionEnabled = true
        ivMap.frame = CGRect(x: 0, y: 0, width: mapSize().width, height: mapSize().height)
        scrollView.addSubview(ivMap)
        
        popTip.bubbleColor = UIColor.white

    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        initialZoomScale()
        
    }
    
    public func reloadData() {
        layoutAnnotations()
    }
    
    func initialZoomScale() {
        if !isInitialScaled {
            if let mapImage = self.mapImage {
                let mapSize = mapImage.size
                let screenSize = UIScreen.main.bounds.size
                let widthScale =  screenSize.width / mapSize.width
                let heightScale =  screenSize.height / mapSize.height
                
                let minScale = widthScale < heightScale ? widthScale : heightScale
                scrollView.minimumZoomScale = minScale
                scrollView.maximumZoomScale = 1
                scrollView.setZoomScale(minScale, animated: false)

            }
            isInitialScaled = true
        }
    }
    
    func mapSize() -> CGSize {
        if let mapImage = self.mapImage {
            return mapImage.size
        }
        return CGSize(width: 0, height: 0)
    }
    
    func layoutAnnotations() {
        for marker in markers {
            let annotationView = CKMapAnotationView(marker: marker)
            annotationView.clickBlock = { annotationView in
                self.showPopView(annotationView: annotationView)
            }
            ivMap.addSubview(annotationView)
            
        }
    }
    
    func showPopView(annotationView: CKMapAnotationView) {
        let infoView = CKMapPopView(marker: annotationView.marker!)
        popTip.show(customView: infoView, direction: .up, in: ivMap, from: annotationView.frame)
    }
    
}


extension CKImageMapView :  UIScrollViewDelegate {
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ivMap
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let subView = scrollView.subviews.first
        
        let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) / 2, 0)
        let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) / 2, 0)
        subView?.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
    }
    
}
