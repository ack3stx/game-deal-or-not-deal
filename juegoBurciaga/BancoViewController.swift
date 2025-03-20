//
//  BancoViewController.swift
//  juegoBurciaga
//
//  Created by mac on 05/03/25.
//

import UIKit

class BancoViewController: UIViewController {

    @IBOutlet weak var lblPremio: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func Deal() {
        self.performSegue(withIdentifier: "premio", sender: nil)
    }
    
    
    @IBAction func NoDeal() {
        self.performSegue(withIdentifier: "regresarJuego", sender: nil)
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
