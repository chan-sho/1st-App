//
//  ViewController.swift
//  1st app
//
//  Created by 高野翔 on 2018/07/28.
//  Copyright © 2018年 高野翔. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonToBack: UIButton!

    var pinView:MKPinAnnotationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputText.delegate = self
        
        label.text = "↑ 投稿する場所を検索"
        label.textColor = UIColor.black // 黒
        label.backgroundColor = UIColor.white // 白
        
        buttonToBack.setTitle("戻る", for: UIControlState.normal)
        buttonToBack.setTitleColor(UIColor.white, for: UIControlState.normal)
        buttonToBack.backgroundColor = UIColor.gray
        buttonToBack.layer.borderColor = UIColor.black.cgColor
        buttonToBack.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        buttonToBack.layer.borderWidth = 1.0
        buttonToBack.layer.cornerRadius = 10.0 //丸みを数値で変更できる
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
                    pin.subtitle = "OKなら「投稿」をクリック"
                    
                    self.displayMap.addAnnotation(pin)
                    self.displayMap.region = MKCoordinateRegionMakeWithDistance(targetCoordinate,500.0,500.0)
                }
            }
        })
        
        return true
    }
    
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var displayMap: MKMapView!
    
    @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
        //この処理を書くことにより、指を離したときだけ反応するようにする（何回も呼び出されないようになる。最後の話したタイミングで呼ばれる）
        if sender.state != UIGestureRecognizerState.began {
            return
        }
        
        //senderから長押しした地図上の座標を取得
        let tappedLocation = sender.location(in: displayMap)
        let tappedPoint = displayMap.convert(tappedLocation, toCoordinateFrom: displayMap)
        // update annotation
        displayMap.removeAnnotations(displayMap.annotations)
        //ピンの生成
        let pin = MKPointAnnotation()
        //ピンを置く場所を指定
        pin.coordinate = tappedPoint
        //ピンのタイトルを設定
        pin.title = "この場所で良いですか？"
        //ピンのサブタイトルの設定
        pin.subtitle = "OKなら「投稿」をクリック"
        //ピンをdisplayMapの上に置く
        self.displayMap.addAnnotation(pin)
    }
    //アノテーションビューを返すメソッド
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        //アノテーションビューを作成する。
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        //アノテーションビューに座標、タイトル、サブタイトルを設定する。
        pinView.annotation = annotation
        //アノテーションビューに色を設定する。
        pinView.backgroundColor = UIColor.white
        //吹き出しを表示可能にする。
        pinView.canShowCallout = true
        
        return pinView
    }
}

