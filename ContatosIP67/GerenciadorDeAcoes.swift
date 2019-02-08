//
//  GerenciadorDeAcoes.swift
//  ContatosIP67
//
//  Created by ios8207 on 2/7/19.
//  Copyright © 2019 vargas. All rights reserved.
//

import UIKit

class GerenciadorDeAcoes: NSObject {
    let contato:Contato
    var controller:UIViewController!
    
    init(do contato:Contato){
        self.contato = contato
    }
    
    func exibirAcoes(em controller:UIViewController){
        self.controller = controller
        let alertView = UIAlertController(title: self.contato.nome, message: nil, preferredStyle: .actionSheet)
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let ligarParaContato = UIAlertAction(title: "Ligar", style: .default){ action in
            self.ligar()
        }
        let exibirContatoNoMapa = UIAlertAction(title: "Visualizar No Mapa", style: .default){action in
            self.abrirMapa()
        }
        let exibirSiteDoContato = UIAlertAction(title: "Visualizar Site", style: .default){action in
            self.abrirNavegador()
        }
        
        alertView.addAction(cancelar)
        alertView.addAction(ligarParaContato)
        alertView.addAction(exibirContatoNoMapa)
        alertView.addAction(exibirSiteDoContato)
        
        self.controller.present(alertView, animated: true, completion: nil)
        
        }
    
    private func ligar(){
        
    }
    
    private func abrirNavegador(){
        
    }
    
    private func abrirMapa(){
        
    }
    
    }

