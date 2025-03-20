//
//  MenuViewController.swift
//  juegoBurciaga
//
//  Created by mac on 03/03/25.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var btnJugar: UIButton!
    
    @IBOutlet weak var btnMarcador: UIButton!
    
    @IBOutlet weak var btnCreditos: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnJugar.layer.cornerRadius = 10
        btnCreditos.layer.cornerRadius = 10
        btnMarcador.layer.cornerRadius = 10
        agregarBrillo(to: btnJugar)
        agregarBrillo(to: btnMarcador)
        agregarBrillo(to: btnCreditos)
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
}
