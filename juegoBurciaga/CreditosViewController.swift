//
//  CreditosViewController.swift
//  juegoBurciaga
//
//  Created by mac on 05/03/25.
//

import UIKit
import AVFoundation

class CreditosViewController: UIViewController {
    @IBOutlet weak var lblParticipante: UILabel!
    @IBOutlet weak var lblParticipante2: UILabel!
    @IBOutlet weak var lblParticipante3: UILabel!
    var cancionFondo = ["GTA"]
    var reproductorMuscia = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        diseño(to: [lblParticipante,lblParticipante2,lblParticipante3])
        reproducirCancionFondo()
    }
    //METODO PARA REPRODUCIR LA MUSICA
    func reproducirCancionFondo() {
        guard let urlCancionFondo = Bundle.main.url(forResource: cancionFondo[0], withExtension: "mp3") else { return }
        do {
            reproductorMuscia = try AVAudioPlayer(contentsOf: urlCancionFondo)
            reproductorMuscia.numberOfLoops = -1
            reproductorMuscia.play()
        }
        catch{
            print("error al reproducir la musica")
        }
    }
    // DETENER LA MUSICA EN CASO LLEGUE A FALLAR Y NO SE DETENGA
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reproductorMuscia.stop()
    }
    
    //DETENR LA MUSICA EN LOS SEWEY
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        reproductorMuscia.stop()
    }
    // FUNCION PARA APLICAR DISEÑO A MIS LABELS
    func diseño(to labels: [UILabel])
    {
        for label in labels
        {
            label.layer.borderColor = UIColor.yellow.cgColor
                label.layer.borderWidth = 2.0
                label.layer.cornerRadius = 8.0
                label.clipsToBounds = true
        }
    }

   
}
