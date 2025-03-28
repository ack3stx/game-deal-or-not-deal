//
//  InstruccionesViewController.swift
//  juegoBurciaga
//
//  Created by mac on 28/03/25.
//

import UIKit

class InstruccionesViewController: UIViewController {

    @IBOutlet weak var scrInstrucciones: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // INSTRUCCIONES
                let instruccionesTexto = """
                Bienvenidos al juego "Deal or No Deal". En este juego tienes 16 maletines, cada uno con una cantidad de dinero aleatoria desde 1 dolar hasta 1 millon de dolares.

                1. Elige tu maletín: Al inicio del juego, seleccionas uno de los 16 maletines.
                
                2. Abre maletines: Comienzas a abrir maletines uno por uno. Cada maletín revela una cantidad de dinero que no podrás ganar.
                
                3. El Bankero aparece: En cierta ronda, el bankero te hará una oferta. El dinero ofrecido es una cantidad basada en lo que queda en los maletines restantes.
                
                4. ¿Aceptar trato?: Puedes aceptar la oferta del bankero, lo que terminaría el juego y te llevarías el dinero ofrecido.
                
                5. Continuar abriendo maletines: Si decides no aceptar la oferta, seguirás abriendo maletines hasta llegar a la última ronda.

                6. Última ronda: En la última ronda, solo queda un maletín, y debes decidir si te quedas con el maletín que elegiste al inicio o con el maletín restante.
                
                ¡Buena suerte!
                """

                // CREAR EL LABEL DE LAS INSTRUCCIONES
                let instruccionesLabel = UILabel()
                instruccionesLabel.numberOfLines = 0
                instruccionesLabel.textColor = .white
                instruccionesLabel.text = instruccionesTexto
                instruccionesLabel.frame = CGRect(x: 20, y: 20, width: 300, height: 0)
                
                // USAR EL FRAME PARA CALCULAR EL TAMAÑO DEL LABEL
                let maxSize = CGSize(width: scrInstrucciones.frame.size.width - 40, height: CGFloat.greatestFiniteMagnitude)
                let labelSize = instruccionesLabel.sizeThatFits(maxSize)
                
                // AJUSTAR EL TAMAÑO DEL LABEL Y AGREGARLO AL SCORLL
                instruccionesLabel.frame = CGRect(x: 20, y: 20, width: labelSize.width, height: labelSize.height)
                scrInstrucciones.addSubview(instruccionesLabel)
                
                // AJUSTAR EL CONTENIDO DEL SCROLL
                scrInstrucciones.contentSize = CGSize(width: scrInstrucciones.frame.size.width, height: instruccionesLabel.frame.origin.y + instruccionesLabel.frame.height + 20)
            
    }
    

}
