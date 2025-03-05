//
//  ResultadoViewController.swift
//  juegoBurciaga
//
//  Created by mac on 05/03/25.
//

import UIKit

class ResultadoViewController: UIViewController {

    @IBOutlet weak var btnMaletin: UIButton!
    @IBOutlet var lblValores: [UIView]!
    var numero:Int!
    var seleccionados: [Int]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnMaletin.setTitle(String(numero), for: .normal)
        btnMaletin.isUserInteractionEnabled = false
        
        for views in lblValores {
            for seleccionado in seleccionados {
                if seleccionado != numero && views.tag == seleccionado {
                    views.alpha = 0.4
                }
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            UIView.animate(withDuration: 2) {
                self.btnMaletin.alpha = 0
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
