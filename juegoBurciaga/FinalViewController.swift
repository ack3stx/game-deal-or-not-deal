//
//  FinalViewController.swift
//  juegoBurciaga
//
//  Created by mac on 14/03/25.
//

import UIKit

class FinalViewController: UIViewController {

    @IBOutlet weak var maletinGuardado: UIButton!
    @IBOutlet weak var btnUltimoMaletin: UIButton!
    @IBOutlet weak var mostrarMaletin: UIView!
    var maletinGuardadoTag: Int = 0
    var valorMaletinGuardado: Int = 0
    var ultimoMaletinTag: Int = 0
    var valorUltimoMaletin: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        maletinGuardado.setTitle(String(maletinGuardadoTag), for: .normal)
        btnUltimoMaletin.setTitle(String(ultimoMaletinTag), for: .normal)
        maletinGuardado.tag = maletinGuardadoTag
        btnUltimoMaletin.tag = ultimoMaletinTag
    }
    
    @IBAction func abrirMaletin(_ sender: UIButton) {
        maletinGuardado.isUserInteractionEnabled = false
        btnUltimoMaletin.isUserInteractionEnabled = false
        UIView.animate(withDuration: 2) {
            sender.frame.origin.x = self.mostrarMaletin.frame.origin.x + (self.mostrarMaletin.frame.width / 2) - (sender.frame.width / 2)
            sender.frame.origin.y = self.mostrarMaletin.frame.origin.y + (self.mostrarMaletin.frame.height / 2) - (sender.frame.height / 2)
            
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                self.performSegue(withIdentifier: "premio", sender: nil)
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
