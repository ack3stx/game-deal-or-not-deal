//
//  ViewController.swift
//  juegoBurciaga
//
//  Created by mac on 03/03/25.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imvSplash: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //let w = view.frame.width * 0.8
        //let h = w * 1.0
        //let x = (view.frame.width - w) / 2
        //let y = -h
        //imvSplash.frame = CGRect(x: x, y: y, width: w, height: h)
        //imvSplash.alpha = 0.0
        //UIView.animate(withDuration: 2.0){
          //  self.imvSplash.frame.origin.y = (self.view.frame.height - h)/2.0
            //self.imvSplash.alpha = 1.0
        //}completion: { fin in
          //  self.performSegue(withIdentifier: "sgSplash", sender: nil)
        //}
        let w = view.frame.width * 0.8
            let h = w * 1.0
            let x = (view.frame.width - w) / 2
            let y = view.frame.height
            imvSplash.frame = CGRect(x: x, y: y, width: w, height: h)
            imvSplash.alpha = 0.0
            
            UIView.animate(withDuration: 2.0) {
                self.imvSplash.frame.origin.y = (self.view.frame.height - h) / 2.0
                self.imvSplash.alpha = 1.0
            } completion: { fin in
                self.performSegue(withIdentifier: "sgSplash", sender: nil)
            }
    }


}

