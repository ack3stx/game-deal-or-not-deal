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
    @IBOutlet weak var lblResultado: UILabel!
    var numero:Int!
    var seleccionados: [Int]!
    var valorSeleccionado: Int!
    var progreso = Datos.sharedDatos()
    override func viewDidLoad() {
        super.viewDidLoad()
        valorSeleccionado = progreso.valores[numero - 1]
        seleccionados = progreso.seleccionados
        // Do any additional setup after loading the view.
        btnMaletin.setTitle(String(numero), for: .normal)
        btnMaletin.isUserInteractionEnabled = false
        lblResultado.text = "$ \(valorSeleccionado!)"
        lblResultado.frame = CGRect(x: btnMaletin.frame.origin.x + btnMaletin.frame.width / 2 - lblResultado.frame.width / 2, y: btnMaletin.frame.origin.y + btnMaletin.frame.height / 2 - lblResultado.frame.height - 10, width: lblResultado.frame.width, height: lblResultado.frame.height)
        for views in lblValores {
            for seleccionado in seleccionados {
                if seleccionado != valorSeleccionado && views.tag == seleccionado {
                    views.alpha = 0.4
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            UIView.animate(withDuration: 2) {
                self.btnMaletin.alpha = 0
            }
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                UIView.animate(withDuration: 2) {
                    for views in self.lblValores {
                        if views.tag == self.valorSeleccionado {
                            //views.alpha = 0.4
                            self.discardValueWithShake(views)
                        }
                    }
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                        UIView.animate(withDuration: 2) {
                            let ronda = self.progreso.ronda
                            if ronda == 5 || ronda == 8 || ronda == 10 || ronda == 12 || ronda == 13 || ronda == 14 || ronda == 15 {
                                self.performSegue(withIdentifier: "banco", sender: nil)
                            }
                            else {
                                self.performSegue(withIdentifier: "regresarJuego", sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func discardValueWithShake(_ label: UIView) {
        let shake = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shake.timingFunction = CAMediaTimingFunction(name: .linear)
        shake.duration = 0.5
        shake.values = [-10, 10, -8, 8, -5, 5, 0]
        label.layer.add(shake, forKey: "shake")
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            label.alpha = 0.4
        })
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
