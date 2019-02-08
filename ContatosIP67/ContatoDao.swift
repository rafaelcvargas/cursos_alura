//
//  ContatoDao.swift
//  ContatosIP67
//
//  Created by ios8207 on 2/5/19.
//  Copyright © 2019 vargas. All rights reserved.
//

import UIKit
import Foundation

class ContatoDao: NSObject {
    static private var defaultDAO: ContatoDao!
    var contatos: Array<Contato>!

    func adiciona(_ contato:Contato){
        contatos.append(contato)
    }
    
    static func sharedInstance() -> ContatoDao{
        if defaultDAO == nil{
            defaultDAO = ContatoDao()
        }
        return defaultDAO
    }
    
    override private init(){
        self.contatos = Array()
        super.init()
    }
    
    func listaTodos() -> [Contato]{
        return contatos
    }
    
    func buscarContatoNaPosicao(_ posicao:Int) -> Contato{
        return contatos[posicao]
    }
    
    func remove(_ posicao:Int){
        contatos.remove(at: posicao)
    }
    
    func buscaPosicaoDoContato(_ contato:Contato) -> Int{
        return contatos.index(of: contato)!
    }
}

