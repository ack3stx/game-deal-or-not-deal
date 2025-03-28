//
//  Datos.swift
//  juegoBurciaga
//
//  Created by mac on 20/03/25.
//

import UIKit

class Datos: NSObject {
    var valores: [Int]
    var seleccionados: [Int]
    var seleccionadosTag: [Int]
    var ronda: Int
    var maletinGuardadoTag: Int
    var valorGanado: Int
    var resultadoFinal: [Int] = []
    var tiempo: Int = 0
    static var datos: Datos!
    
    override init() {
        valores = []
        seleccionados = []
        seleccionadosTag = []
        ronda = 0
        maletinGuardadoTag = -1
        valorGanado = 0
    }
    
    static func sharedDatos() -> Datos {
        if datos == nil {
            datos = Datos.init()
        }
        return datos
    }
}
