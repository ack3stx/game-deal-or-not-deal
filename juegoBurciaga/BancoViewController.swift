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
        
        for i in 0 ..< progreso.valores.count {
            // Verificamos si el valor NO está en el array de seleccionados
            if !progreso.seleccionados.contains(progreso.valores[i]) {
                // Si no está seleccionado, lo sumamos al total
                CantidadTotal += progreso.valores[i]
            }
        }
        
        CantidadTotal = CantidadTotal / progreso.seleccionados.count
        
        if (progreso.ronda == 5){
            
            let resultado = Double(CantidadTotal) * 0.6
            CantidadTotal = Int(resultado.rounded())

        }

        return CantidadTotal
        
    }

    @IBAction func Deal() {
        
        progreso.valorGanado = CantidadTotal
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
