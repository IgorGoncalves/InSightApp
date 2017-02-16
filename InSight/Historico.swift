//
//  HistoricoLocais.swift
//  InSight
//
//  Created by Student on 2/14/17.
//  Copyright © 2017 Ramon Lima. All rights reserved.
//

import Foundation

class Historico{
    
    let local:String;
    let descricao:String;
    let direcao:String;
    let distancia:Double;
    
    
    
    init( local:String, descricao:String, direcao:String, distancia:Double){
        self.local = local;
        self.descricao = descricao;
        self.direcao = direcao;
        self.distancia = distancia;
    }
    
    
}
