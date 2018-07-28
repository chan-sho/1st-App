//
//  ViewController.swift
//  1st app
//
//  Created by 高野翔 on 2018/07/28.
//  Copyright © 2018年 高野翔. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonForsearchPlace: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputText.delegate = self
        
        label.text = "↑ STEP1: 投稿する場所を検索"
        label.textColor = UIColor.blue // 青
        label.backgroundColor = UIColor.white // 白
        
        buttonForsearchPlace.setTitle("住所を検索して投稿", for: UIControlState.normal)
        buttonForsearchPlace.setTitleColor(UIColor.red, for: UIControlState.normal)
        buttonForsearchPlace.layer.borderColor = UIColor.red.cgColor
        buttonForsearchPlace.layer.borderWidth = 1.0
        buttonForsearchPlace.layer.cornerRadius = 10.0 //丸みを数値で変更できる
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let searchKeyword = textField.text
        
        print(searchKeyword!)
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(searchKeyword!, completionHandler: { (placemarks:[CLPlacemark]?, error:Error?) in
            
            if let placemark = placemarks?[0] {
                if let targetCoordinate = placemark.location?.coordinate {
                    print(targetCoordinate)
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = targetCoordinate
                    pin.title = searchKeyword
                    
                    self.displayMap.addAnnotation(pin)
                    self.displayMap.region = MKCoordinateRegionMakeWithDistance(targetCoordinate,500.0,500.0)
                }
            }
        })
        
        
        
        return true
    }
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var displayMap: MKMapView!
}

