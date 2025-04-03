//
//  JuegoViewController.swift
//  juegoBurciaga
//
//  Created by mac on 03/03/25.
//

import UIKit
import AVFoundation

class JuegoViewController: UIViewController {

    @IBOutlet weak var lblInstrucciones: UILabel!
    let numeros: [Int] = [400, 500, 750, 1000, 5000, 10000, 25000, 50000, 75000, 100000, 200000, 300000, 400000, 500000, 750000, 1000000]
    var valores: [Int] = []
    var numero: Int = 0
    var seleccionados: [Int] = []
    var seleccionadosTag: [Int] = []
    var ronda: Int = 0
    var maletinGuardadoTag: Int = -1
    var cronometro = Timer()
    var tiempo = 0
    @IBOutlet weak var lblCronometro: UILabel!
    var progreso = Datos.sharedDatos()
    @IBOutlet weak var maletaGuardada: UIView!
    @IBOutlet var btnMaletines: [UIButton]!
    var reproductor = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        valores = progreso.valores
        seleccionados = progreso.seleccionados
        seleccionadosTag = progreso.seleccionadosTag
        ronda = progreso.ronda
        maletinGuardadoTag = progreso.maletinGuardadoTag
        tiempo = progreso.tiempo
        
        
//        reproductor.stop()
        // Do any additional setup after loading the view.
        
        if (ronda == 0) {
            lblInstrucciones.text = "Selecciona el maletin a guardar"
        }
        else {
            lblInstrucciones.text = "Selecciona el maletin a descartar"
        }
        
        if (ronda < 8) {
            if progreso.nombreMusica != "juegoPrimerasRondas" {
                self.playSound("juegoPrimerasRondas")
            }
        }
        else if (ronda < 12) {
            if progreso.nombreMusica == "juegoPrimerasRondas" {
                progreso.reproductor.stop()
            }
            if progreso.nombreMusica != "juegoRondasMedias" {
                self.playSound("juegoRondasMedias")
            }
        }
        else {
            if progreso.nombreMusica == "juegoRondasMedias" {
                progreso.reproductor.stop()
            }
            if progreso.nombreMusica != "juegoRondasFinales" {
                self.playSound("juegoRondasFinales")
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
        
        if valores.count == 0 {
            valores = numeros.shuffled()
        }
        
        print(valores)
        
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
            lblInstrucciones.text = "Selecciona el maletin a descartar"
            maletinGuardadoTag = sender.tag
            sender.isUserInteractionEnabled = false
            UIView.animate(withDuration: 2) {
                sender.frame.origin.x = self.maletaGuardada.frame.origin.x
                sender.frame.origin.y = self.maletaGuardada.frame.origin.y
            }
            ronda += 1
        }
        else {
            
            numero = sender.tag
            sender.isEnabled = false
            
            seleccionados.append(valores[numero - 1])
            seleccionadosTag.append(numero)
            
            ronda += 1
            
            if ronda == 15 {
                for boton in btnMaletines {
                    if boton.isEnabled == true && boton.tag != maletinGuardadoTag {
                        progreso.resultadoFinal = [self.maletinGuardadoTag, self.valores[self.maletinGuardadoTag - 1], boton.tag, self.valores[boton.tag - 1]]
                    }
                }
                
            }
            self.performSegue(withIdentifier: "abrirMaletin", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "abrirMaletin" {
            let vc = segue.destination as! ResultadoViewController
            vc.numero = self.numero
        }
//        reproductor.stop()
        guardarProgreso()
    }
    func guardarProgreso() {
        progreso.valores = valores
        progreso.seleccionados = seleccionados
        progreso.seleccionadosTag = seleccionadosTag
        progreso.ronda = ronda
        progreso.maletinGuardadoTag = maletinGuardadoTag
        progreso.tiempo = tiempo
    }
    
    func playSound(_ musica: String) {
        guard let soundURL = Bundle.main.url(forResource: musica, withExtension: "mp3") else { return }

        do {
            reproductor = try AVAudioPlayer(contentsOf: soundURL)
            reproductor.numberOfLoops = -1
            reproductor.play()
            progreso.reproductor = reproductor
            progreso.nombreMusica = musica
        } catch {
            print("Error al reproducir sonido: \(error.localizedDescription)")
        }
    }
}
