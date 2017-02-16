//
//  HistoricoDAO.swift
//  InSight
//
//  Created by Student on 2/14/17.
//  Copyright © 2017 Ramon Lima. All rights reserved.
//

import Foundation

class HistoricoDAO{
    
    static func getHistorico() -> [Historico]{
        return [
            Historico(local: "Banheiro", descricao: "Banheiro Masculino do Dcomp", direcao: "direita", distancia: 0.45),
            Historico(local: "Secretaria", descricao: "Secretaria do Dcomp", direcao: "esquerda", distancia: 1.50),
            Historico(local: "Softeam", descricao: "Empresa Jr. Dcomp", direcao: "frente", distancia: 2.80)
        ]
    }
    
}
