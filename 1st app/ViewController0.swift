//
//  ViewController0.swift
//  1st app
//
//  Created by 高野翔 on 2018/07/29.
//  Copyright © 2018年 高野翔. All rights reserved.
//

import UIKit

class ViewController0: UIViewController {
    @IBOutlet weak var buttonForCurrentPlace: UIButton!
    
    @IBOutlet weak var buttonForSearchPlace: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonForCurrentPlace.setTitle("現在地から投稿", for: UIControlState.normal)
        buttonForCurrentPlace.setTitleColor(UIColor.blue, for: UIControlState.normal)
        buttonForCurrentPlace.layer.borderColor = UIColor.blue.cgColor
        buttonForCurrentPlace.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        buttonForCurrentPlace.layer.borderWidth = 2.0
        buttonForCurrentPlace.layer.cornerRadius = 10.0 //丸みを数値で変更できる
        
        buttonForSearchPlace.setTitle("場所を検索して投稿", for: UIControlState.normal)
        buttonForSearchPlace.setTitleColor(UIColor.red, for: UIControlState.normal)
        buttonForSearchPlace.layer.borderColor = UIColor.red.cgColor
        buttonForSearchPlace.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        buttonForSearchPlace.layer.borderWidth = 2.0
        buttonForSearchPlace.layer.cornerRadius = 10.0 //丸みを数値で変更できる

        // Do any additional setup after loading the view.
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
