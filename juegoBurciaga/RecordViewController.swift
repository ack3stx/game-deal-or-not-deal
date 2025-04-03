//
//  RecordViewController.swift
//  juegoBurciaga
//
//  Created by mac on 05/03/25.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var Fondo: UIView!
    @IBOutlet var lblJugadores: [UILabel]!
    @IBOutlet var lblPuntajes: [UILabel]!
    var progreso = Datos.sharedDatos()
    override func viewDidLoad() {
        super.viewDidLoad()
        progreso.abrirArchivo()
        Fondo.layer.cornerRadius = 30
        lblTitulo.layer.cornerRadius = 30
        print(progreso.puntajes)
        
        for i in 0..<progreso.puntajes.count{
            lblJugadores[i].text = "\(String(describing: progreso.puntajes[i]["jugador"]!))"
            lblPuntajes[i].text = "\(String(describing: progreso.puntajes[i]["puntaje"]!))"
        }

        // Do any additional setup after loading the view.
    }

}
