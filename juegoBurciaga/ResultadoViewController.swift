//
//  ResultadoViewController.swift
//  juegoBurciaga
//
//  Created by mac on 05/03/25.
//

import UIKit
import AVFoundation

class ResultadoViewController: UIViewController {

    @IBOutlet weak var lblCronometro: UILabel!
    @IBOutlet weak var btnMaletin: UIButton!
    @IBOutlet var lblValores: [UIView]!
    @IBOutlet weak var lblResultado: UILabel!
    var numero:Int!
    var seleccionados: [Int]!
    var valorSeleccionado: Int!
    var cronometro = Timer()
    var tiempo = 0
    var progreso = Datos.sharedDatos()
    let canciones = ["abrirMaletin"]
    var reproductor = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        tiempo = progreso.tiempo
        valorSeleccionado = progreso.valores[numero - 1]
        seleccionados = progreso.seleccionados
        // Do any additional setup after loading the view.
        btnMaletin.setTitle(String(numero), for: .normal)
        btnMaletin.isUserInteractionEnabled = false
        lblResultado.text = "$ \(valorSeleccionado.formatted(.number))"
        lblResultado.frame = CGRect(x: btnMaletin.frame.origin.x + btnMaletin.frame.width / 2 - lblResultado.frame.width / 2, y: btnMaletin.frame.origin.y + btnMaletin.frame.height / 2 - lblResultado.frame.height - 10, width: lblResultado.frame.width, height: lblResultado.frame.height)
        for views in lblValores {
            for seleccionado in seleccionados {
                if seleccionado != valorSeleccionado && views.tag == seleccionado {
                    views.alpha = 0.4
                }
            }
        }
        
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
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            if self.progreso.ronda == 2 && self.valorSeleccionado! == 1000000 {
                self.playSound("jaja")
            }
            else {
                self.playSound("abrirMaletin")
            }
            UIView.animate(withDuration: 1) {
                self.btnMaletin.alpha = 0
            }
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                UIView.animate(withDuration: 1) {
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
        
        UIView.animate(withDuration: 0.2, delay: 0.5, options: [], animations: {
            label.alpha = 0.4
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        progreso.tiempo = tiempo
    }
    
    func playSound(_ musica: String) {
        guard let soundURL = Bundle.main.url(forResource: musica, withExtension: "mp3") else { return }

        do {
            reproductor = try AVAudioPlayer(contentsOf: soundURL)
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
