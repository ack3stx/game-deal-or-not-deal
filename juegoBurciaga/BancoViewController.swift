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
    
    @IBOutlet weak var lblCronometro: UILabel!
    
    
    var CantidadNoSeleccionada: Int = 0
    var CantidadTotal: Int = 0
    
    var cronometro = Timer()
    var tiempo = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tiempo = progreso.tiempo
        
        cronometro = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.tiempo += 1
            
            var segundos = self.tiempo
            var minutos: Int = 0
            var horas: Int = 0
            
            if segundos >= 60 {
                minutos = segundos / 60
                segundos %= 60
            }
            
            
            if minutos >= 60 {
                horas = minutos / 60
                minutos %= 60
            }
            
            var horasString: String = ""
            if horas > 0 {
                horasString = String(format: "%02d", horas) + ":"
            }
            var minutosString: String = ""
            if minutos > 0 {
                minutosString = String(format: "%02d", minutos) + ":"
            }
            let segundosString: String = String(format: "%02d", segundos)
            
            self.lblCronometro.text = "\(horasString)\(minutosString)\(segundosString)"
            
            
        })
        


        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lblPremio.text = "$ " + String(calcularPremio())

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        progreso.tiempo = tiempo
    }
    
    
    func calcularPremio() -> Int {
        
        for i in 0 ..< progreso.valores.count {
            // Verificamos si el valor NO está en el array de seleccionados
            if !progreso.seleccionados.contains(progreso.valores[i]) {
                // Si no está seleccionado, lo sumamos al total
                CantidadTotal += progreso.valores[i]
                CantidadNoSeleccionada = CantidadNoSeleccionada + 1
            }
        }
        
        CantidadTotal = CantidadTotal / CantidadNoSeleccionada
        
        
        switch progreso.ronda {
            case 5: CantidadTotal = Int((Double(CantidadTotal) * 0.1).rounded())
            case 8: CantidadTotal = Int((Double(CantidadTotal) * 0.3).rounded())
            case 10: CantidadTotal = Int((Double(CantidadTotal) * 0.6).rounded())
        case 13: CantidadTotal = Int((Double(CantidadTotal) * 0.7).rounded())
        case 14: CantidadTotal = Int((Double(CantidadTotal) * 0.8).rounded())
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
