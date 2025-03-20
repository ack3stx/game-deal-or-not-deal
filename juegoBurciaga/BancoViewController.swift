//
//  BancoViewController.swift
//  juegoBurciaga
//
//  Created by mac on 05/03/25.
//

import UIKit

class BancoViewController: UIViewController {

    
    var progreso = Datos.sharedDatos()
    @IBOutlet weak var lblPremio: UILabel!
    
    var CantidadTotal: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblPremio.text = "$ " + String(calcularPremio())

        // Do any additional setup after loading the view.
    }
    
    func calcularPremio() -> Int {
        

        for progreso.valores in progreso.valores {
            // Verificamos si el valor NO está en el array de seleccionados
            if !progreso.seleccionados.contains(valor) {
                // Si no está seleccionado, lo sumamos al total
                CantidadTotal += valor
            }
        }
        
        return CantidadTotal
        
    }

    @IBAction func Deal() {
        self.performSegue(withIdentifier: "premio", sender: nil)
    }
    
    
    @IBAction func NoDeal() {
        self.performSegue(withIdentifier: "regresarJuego", sender: nil)
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
