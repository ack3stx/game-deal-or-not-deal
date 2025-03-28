//
//  EndGameViewController.swift
//  juegoBurciaga
//
//  Created by mac on 05/03/25.
//

import UIKit

class EndGameViewController: UIViewController {

    
    var progreso = Datos.sharedDatos()

    @IBOutlet weak var lblPremio: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lblPremio.text = "$ " + String(progreso.valorGanado)
        mostrarAlertaParaNombre(puntaje: progreso.valorGanado)
    }
    
    func mostrarAlertaParaNombre(puntaje: Int) {
        if let menorScore = progreso.obtenerMenorScore(), puntaje <= menorScore && progreso.puntajes.count >= 5 {
        
            let alerta = UIAlertController(
                title: "¡Has roto un nuevo récord con un puntaje de: \(puntaje)!",
                message: "Ingresa tu nombre",
                preferredStyle: .alert
            )
            
            alerta.addTextField { textField in
                textField.placeholder = "Nombre"
            }
            
            let guardarAccion = UIAlertAction(title: "Guardar", style: .default) { _ in
                guard let nombre = alerta.textFields?.first?.text, !nombre.isEmpty else {
                    self.mostrarAlertaParaNombre(puntaje: puntaje)
                    return
                }
                
                self.progreso.agregarPuntaje(
                    jugador: nombre,
                    puntaje: puntaje
                )
                
            }
            
            alerta.addAction(guardarAccion)
            present(alerta, animated: true)
        }

        else{
            
            let alerta = UIAlertController(
                title: "¡Gracias por jugar!",
                message: "Tu puntaje fue de: \(puntaje)",
                preferredStyle: .alert
            )

            let aceptarAction = UIAlertAction(title: "Aceptar", style: .default) { _ in
                
            }

            alerta.addAction(aceptarAction)

            self.present(alerta, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func MenuSalir(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let juegovc = storyboard.instantiateViewController(withIdentifier: "menu")
        juegovc.modalPresentationStyle = .fullScreen
        present(juegovc, animated: true)
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
