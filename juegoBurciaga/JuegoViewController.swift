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
    var seleccionadosTag: [Int] = []
    var ronda: Int = 0
    var maletinGuardadoTag: Int = -1
    var progreso = Datos.sharedDatos()
    @IBOutlet weak var maletaGuardada: UIView!
    @IBOutlet var btnMaletines: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        valores = progreso.valores
        seleccionados = progreso.seleccionados
        seleccionadosTag = progreso.seleccionadosTag
        ronda = progreso.ronda
        maletinGuardadoTag = progreso.maletinGuardadoTag
        
        // Do any additional setup after loading the view.
        if valores.count == 0 {
            valores = numeros.shuffled()
        }
        
        if maletinGuardadoTag != -1 {
            for boton in btnMaletines {
                if boton.tag == maletinGuardadoTag {
                    boton.isUserInteractionEnabled = false
                    boton.alpha = 0
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if maletinGuardadoTag != -1 {
            for boton in btnMaletines {
                if boton.tag == maletinGuardadoTag {
                    boton.frame.origin.x = -100
                    boton.frame.origin.y = maletaGuardada.frame.origin.y
                    boton.alpha = 1
                    
                    UIView.animate(withDuration: 1) {
                        boton.frame.origin.x = self.maletaGuardada.frame.origin.x
                        boton.frame.origin.y = self.maletaGuardada.frame.origin.y
                    }
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if seleccionadosTag.count > 0 {
            for boton in btnMaletines {
                for seleccionado in seleccionadosTag {
                    if boton.tag == seleccionado {
                        boton.isEnabled = false
                    }
                }
            }
        }
        
    }
    
    @IBAction func seleccionarMaletin(_ sender: UIButton) {
        if ronda == 0 {
            maletinGuardadoTag = sender.tag
            sender.isUserInteractionEnabled = false
            UIView.animate(withDuration: 2) {
                sender.frame.origin.x = self.maletaGuardada.frame.origin.x
                sender.frame.origin.y = self.maletaGuardada.frame.origin.y
            }
            ronda += 1
        }
        else if ronda == 5 {
            self.performSegue(withIdentifier: "banco", sender: nil)
        }
        else if ronda == 6 {
            numero = sender.tag
            self.performSegue(withIdentifier: "resultadoFinal", sender: nil)
        }
        else {
            numero = sender.tag
            sender.isEnabled = false
            
            seleccionados.append(valores[numero - 1])
            seleccionadosTag.append(numero)
            
            ronda += 1
            self.performSegue(withIdentifier: "abrirMaletin", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "abrirMaletin" {
            let vc = segue.destination as! ResultadoViewController
            vc.numero = self.numero
        }
        else if segue.identifier == "resultadoFinal" {
            let vc = segue.destination as! FinalViewController
            vc.maletinGuardadoTag = self.maletinGuardadoTag
            vc.valorMaletinGuardado = self.valores[self.maletinGuardadoTag - 1]
            vc.ultimoMaletinTag = self.numero
            vc.valorUltimoMaletin = self.valores[self.numero - 1]
        }
        
        guardarProgreso()
    }
    func guardarProgreso() {
        progreso.valores = valores
        progreso.seleccionados = seleccionados
        progreso.seleccionadosTag = seleccionadosTag
        progreso.ronda = ronda
        progreso.maletinGuardadoTag = maletinGuardadoTag
    }

}
