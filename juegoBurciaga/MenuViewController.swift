//
//  MenuViewController.swift
//  juegoBurciaga
//
//  Created by mac on 03/03/25.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    @IBOutlet weak var btnJugar: UIButton!
    var cancionInicio = ["Inicio"]
    @IBOutlet weak var btnMarcador: UIButton!
    var reproductorMusica = AVAudioPlayer()
    @IBOutlet weak var btnCreditos: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        reproducirMusica()
        btnJugar.layer.cornerRadius = 10
        btnCreditos.layer.cornerRadius = 10
        btnMarcador.layer.cornerRadius = 10
        agregarBrillo(to: btnJugar)
        agregarBrillo(to: btnMarcador)
        agregarBrillo(to: btnCreditos)
        Datos.init()
        // Do any additional setup after loading the view.
    }
    func agregarBrillo(to button: UIButton) {
            button.layer.shadowColor = UIColor.white.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.layer.shadowRadius = 8
            button.layer.shadowOpacity = 1.0
        }

    @IBAction func empezarJuego(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Juego", bundle: nil)
        
        let juegovc = storyboard.instantiateViewController(withIdentifier: "juego")
        juegovc.modalPresentationStyle = .fullScreen
        present(juegovc, animated: true)
    }
    // METODO PARA REPRODUCIR LA MUSICA
    func reproducirMusica(){
        guard let url = Bundle.main.url(forResource: cancionInicio[0], withExtension: "mp3") else { return }
        do {
            reproductorMusica = try AVAudioPlayer(contentsOf: url)
            reproductorMusica.numberOfLoops = -1
            reproductorMusica.play()
        } catch {
            
        }
    }
    //METODO PARA DETENER LA MUSICA EN CASO LLEGUE A FALLAR Y NO SE DETENGA
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reproductorMusica.stop()
    }
    //DETENR LA MUSICA EN LOS SEWEY
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        reproductorMusica.stop()
    }
}
