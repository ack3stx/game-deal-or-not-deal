//
//  EndGameViewController.swift
//  juegoBurciaga
//
//  Created by mac on 05/03/25.
//

import UIKit

import AVFoundation

class EndGameViewController: UIViewController {

    
    var progreso = Datos.sharedDatos()

    @IBOutlet weak var lblPremio: UILabel!
    var reproductor = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound("1,000,000")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lblPremio.text = "$ " + String(progreso.valorGanado.formatted(.number))
        var puntajeTotal = progreso.tiempo + progreso.valorGanado
        mostrarAlertaParaNombre(puntaje: puntajeTotal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        reproductor.stop()
    }
    
    func mostrarAlertaParaNombre(puntaje: Int) {
        if let menorScore = progreso.obtenerMenorScore(), puntaje > menorScore || progreso.puntajes.count < 5 {
            
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
        } else {
            let alerta = UIAlertController(
                title: "¡Gracias por jugar!",
                message: "Tu puntaje fue de: \(puntaje)",
                preferredStyle: .alert
            )

            let aceptarAction = UIAlertAction(title: "Aceptar", style: .default)
            alerta.addAction(aceptarAction)
            present(alerta, animated: true)
        }
    }
    
    @IBAction func MenuSalir(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let juegovc = storyboard.instantiateViewController(withIdentifier: "menu")
        juegovc.modalPresentationStyle = .fullScreen
        present(juegovc, animated: true)
    }
    
    
    func playSound(_ musica: String) {
        guard let soundURL = Bundle.main.url(forResource: musica, withExtension: "mp3") else { return }

        do {
            reproductor = try AVAudioPlayer(contentsOf: soundURL)
            reproductor.numberOfLoops = -1
            reproductor.play()
        } catch {
            print("Error al reproducir sonido: \(error.localizedDescription)")
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
