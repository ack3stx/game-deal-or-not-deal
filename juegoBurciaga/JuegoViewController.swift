//
//  JuegoViewController.swift
//  juegoBurciaga
//
//  Created by mac on 03/03/25.
//

import UIKit

class JuegoViewController: UIViewController {

    let numeros: [Int] = [400, 500, 750, 1000, 5000, 10000, 25000, 50000, 75000, 100000, 200000, 300000, 400000, 500000, 750000, 1000000]
    var valores: [Int] = []
    var numero: Int = 0
    var seleccionados: [Int] = []
    
    @IBOutlet var btnMaletines: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        valores = numeros.shuffled()

//        for maletin in btnMaletines {
//            print(numerosAleatorios[maletin.tag - 1])
//        }
    }
    
    @IBAction func seleccionarMaletin(_ sender: UIButton) {
        numero = sender.tag
        sender.isEnabled = false
        
        seleccionados.append(numero)
        self.performSegue(withIdentifier: "abrirMaletin", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "abrirMaletin" {
            let vc = segue.destination as! ResultadoViewController
            vc.numero = numero
            vc.seleccionados = seleccionados
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
