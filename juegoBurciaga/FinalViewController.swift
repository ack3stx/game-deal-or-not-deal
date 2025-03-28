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
    var progreso = Datos.sharedDatos()
    override func viewDidLoad() {
        super.viewDidLoad()

        maletinGuardado.setTitle(String(progreso.resultadoFinal[0]), for: .normal)
        btnUltimoMaletin.setTitle(String(progreso.resultadoFinal[2]), for: .normal)
        maletinGuardado.tag = progreso.resultadoFinal[1]
        btnUltimoMaletin.tag = progreso.resultadoFinal[3]
    }
    
    @IBAction func abrirMaletin(_ sender: UIButton) {
        maletinGuardado.isUserInteractionEnabled = false
        btnUltimoMaletin.isUserInteractionEnabled = false
        UIView.animate(withDuration: 2) {
            sender.frame.origin.x = self.mostrarMaletin.frame.origin.x + (self.mostrarMaletin.frame.width / 2) - (sender.frame.width / 2)
            sender.frame.origin.y = self.mostrarMaletin.frame.origin.y + (self.mostrarMaletin.frame.height / 2) - (sender.frame.height / 2)
            
            self.progreso.valorGanado = sender.tag
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                self.performSegue(withIdentifier: "premio", sender: nil)
            }
        }
    }
}
