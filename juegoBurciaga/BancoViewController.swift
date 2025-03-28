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
        
        print(CantidadTotal)
        
        CantidadTotal = CantidadTotal / progreso.seleccionados.count
        
        print(CantidadTotal)
        
        switch progreso.ronda {
            case 5: CantidadTotal = Int((Double(CantidadTotal) * 0.2).rounded())
            case 8: CantidadTotal = Int((Double(CantidadTotal) * 0.4).rounded())
            case 10: CantidadTotal = Int((Double(CantidadTotal) * 0.85).rounded())
            case 13: CantidadTotal = Int((Double(CantidadTotal) * 1).rounded())
            case 14: CantidadTotal = Int((Double(CantidadTotal) * 1.20).rounded())
            default: break
            
        }
        
        return CantidadTotal
        
    }

    @IBAction func Deal() {
        
        progreso.valorGanado = CantidadTotal
        self.performSegue(withIdentifier: "premio", sender: nil)
        
        
    }
    
    
    @IBAction func NoDeal() {
        if (progreso.ronda == 15){
            self.performSegue(withIdentifier: "resultadoFinal", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "regresarJuego", sender: nil)
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
