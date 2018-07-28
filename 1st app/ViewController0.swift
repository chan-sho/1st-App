//
//  ViewController0.swift
//  1st app
//
//  Created by 高野翔 on 2018/07/29.
//  Copyright © 2018年 高野翔. All rights reserved.
//

import UIKit

class ViewController0: UIViewController {
    @IBOutlet weak var buttonForsearchPlace: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonForsearchPlace.setTitle("場所を検索して投稿", for: UIControlState.normal)
        buttonForsearchPlace.setTitleColor(UIColor.red, for: UIControlState.normal)
        buttonForsearchPlace.layer.borderColor = UIColor.red.cgColor
        buttonForsearchPlace.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        buttonForsearchPlace.layer.borderWidth = 2.0
        buttonForsearchPlace.layer.cornerRadius = 10.0 //丸みを数値で変更できる

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
