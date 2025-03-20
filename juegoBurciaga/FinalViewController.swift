//
//  FinalViewController.swift
//  juegoBurciaga
//
//  Created by mac on 14/03/25.
//

import UIKit

class FinalViewController: UIViewController {

    @IBOutlet weak var maletinGuardado: UIButton!
    @IBOutlet weak var lblMaletinGuardado: UILabel!
    @IBOutlet weak var btnUltimoMaletin: UIButton!
    @IBOutlet weak var lblUltimoMaletin: UILabel!
    var maletinGuardadoTag: Int = 0
    var valorMaletinGuardado: Int = 0
    var ultimoMaletinTag: Int = 0
    var valorUltimoMaletin: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        maletinGuardado.setTitle(String(maletinGuardadoTag), for: .normal)
        lblMaletinGuardado.text = "$ \(valorMaletinGuardado)"
        btnUltimoMaletin.setTitle(String(ultimoMaletinTag), for: .normal)
        lblUltimoMaletin.text = "$ \(valorUltimoMaletin)"
        
        maletinGuardado.tag = maletinGuardadoTag
        btnUltimoMaletin.tag = ultimoMaletinTag
        btnUltimoMaletin.isEnabled = false
        btnUltimoMaletin.setTitle("", for: .normal)
    }
    
    @IBAction func abrirMaletin(_ sender: UIButton) {
        
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
