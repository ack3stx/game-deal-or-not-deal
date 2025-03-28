//
//  FinalViewController.swift
//  juegoBurciaga
//
//  Created by mac on 14/03/25.
//

import UIKit
import AVFoundation

class FinalViewController: UIViewController {

    @IBOutlet weak var lblTim: UILabel!
    @IBOutlet weak var maletinGuardado: UIButton!
    @IBOutlet weak var btnUltimoMaletin: UIButton!
    @IBOutlet weak var mostrarMaletin: UIView!
    var maletinGuardadoTag: Int = 0
    var valorMaletinGuardado: Int = 0
    var ultimoMaletinTag: Int = 0
    var valorUltimoMaletin: Int = 0
    var cronometro = Timer()
    var tiempo = 0
    var progreso = Datos.sharedDatos()
    var reproductor = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playSound("ultimosDosMaletines")
        
        tiempo = progreso.tiempo

        maletinGuardado.setTitle(String(progreso.resultadoFinal[0]), for: .normal)
        btnUltimoMaletin.setTitle(String(progreso.resultadoFinal[2]), for: .normal)
        maletinGuardado.tag = progreso.resultadoFinal[1]
        btnUltimoMaletin.tag = progreso.resultadoFinal[3]
        
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
            
            self.lblTim.text = "\(horasString)\(minutosString)\(segundosString)"
        })
    }
    
    @IBAction func abrirMaletin(_ sender: UIButton) {
        maletinGuardado.isUserInteractionEnabled = false
        btnUltimoMaletin.isUserInteractionEnabled = false
            
        let destinoX = mostrarMaletin.frame.midX - sender.frame.width / 2
        let destinoY = mostrarMaletin.frame.midY - sender.frame.height / 2
            
        UIView.animate(withDuration: 2, animations: {
            sender.transform = CGAffineTransform(translationX: destinoX - sender.frame.origin.x, y: destinoY - sender.frame.origin.y)}) { _ in
            self.progreso.valorGanado = sender.tag
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                self.performSegue(withIdentifier: "premio", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        progreso.tiempo = tiempo
        reproductor.stop()
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
}
