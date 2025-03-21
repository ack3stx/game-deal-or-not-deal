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
        
        lblPremio.text = "$ " + String( progreso.valorGanado)

        // Do any additional setup after loading the view.
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
