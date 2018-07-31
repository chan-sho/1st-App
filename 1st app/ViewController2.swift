//
//  ViewController2.swift
//  1st app
//
//  Created by 高野翔 on 2018/07/31.
//  Copyright © 2018年 高野翔. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController2: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var displayMapView: MKMapView!
    @IBOutlet weak var buttonToBack: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var testManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //デリゲート先に自分を設定する。
        testManager.delegate = self
        //位置情報の取得を開始する。
        testManager.startUpdatingLocation()
        //位置情報の利用許可を変更する画面をポップアップ表示する。
        testManager.requestWhenInUseAuthorization()
        
        label.text = "指定したい場所を長押し"
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
    
    //画面表示後の呼び出しメソッド
    override func viewDidAppear(_ animated: Bool) {
        
        if(CLLocationManager.locationServicesEnabled() == true){
            switch CLLocationManager.authorizationStatus() {
                
            //未設定の場合
            case CLAuthorizationStatus.notDetermined:
                testManager.requestWhenInUseAuthorization()
                
            //機能制限されている場合
            case CLAuthorizationStatus.restricted:
                alertMessage(message: "位置情報サービスの利用が制限されている利用できません。「設定」⇒「一般」⇒「機能制限」")
                
            //「許可しない」に設定されている場合
            case CLAuthorizationStatus.denied:
                alertMessage(message: "位置情報の利用が許可されていないため利用できません。「設定」⇒「プライバシー」⇒「位置情報サービス」⇒「アプリ名」")
                
            //「このAppの使用中のみ許可」に設定されている場合
            case CLAuthorizationStatus.authorizedWhenInUse:
                //位置情報の取得を開始する。
                testManager.startUpdatingLocation()
                
            //「常に許可」に設定されている場合
            case CLAuthorizationStatus.authorizedAlways:
                //位置情報の取得を開始する。
                testManager.startUpdatingLocation()
            }
            
        } else {
            //位置情報サービスがOFFの場合
            alertMessage(message: "位置情報サービスがONになっていないため利用できません。「設定」⇒「プライバシー」⇒「位置情報サービス」")
        }
    }
    
    
    
    //メッセージ出力メソッド
    func alertMessage(message:String) {
        let aleartController = UIAlertController(title: "注意", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"OK", style: .default, handler:nil)
        aleartController.addAction(defaultAction)
        
        present(aleartController, animated:true, completion:nil)
        
    }
    
    //位置情報取得時の呼び出しメソッド
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            
            //中心座標
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            
            //表示範囲
            let span = MKCoordinateSpanMake(0.01, 0.01)
            
            //中心座標と表示範囲をマップに登録する。
            let region = MKCoordinateRegionMake(center, span)
            displayMapView.setRegion(region, animated:true)
            
            //ピンを作成してマップビューに登録する。
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, pin.coordinate.longitude)
            self.displayMapView.addAnnotation(pin)
            //ピンのタイトルを設定
            pin.title = "この場所で良いですか？"
            //ピンのサブタイトルの設定
            pin.subtitle = "OKなら「投稿」をクリック"
            
        }
    }
    
    @IBAction func longPressGesture(_ sender: UILongPressGestureRecognizer) {
        //この処理を書くことにより、指を離したときだけ反応するようにする（何回も呼び出されないようになる。最後の話したタイミングで呼ばれる）
        if sender.state != UIGestureRecognizerState.began {
            return
        }
        
        //senderから長押しした地図上の座標を取得
        let tappedLocation = sender.location(in: displayMapView)
        let tappedPoint = displayMapView.convert(tappedLocation, toCoordinateFrom: displayMapView)
        // update annotation
        displayMapView.removeAnnotations(displayMapView.annotations)
        //ピンの生成
        let pin = MKPointAnnotation()
        //ピンを置く場所を指定
        pin.coordinate = tappedPoint
        //ピンのタイトルを設定
        pin.title = "この場所で良いですか？"
        //ピンのサブタイトルの設定
        pin.subtitle = "OKなら「投稿」をクリック"
        //ピンをdisplayMapの上に置く
        self.displayMapView.addAnnotation(pin)
    }
}
