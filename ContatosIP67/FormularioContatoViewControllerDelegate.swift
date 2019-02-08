//
//  FormularioContatoViewControllerDelegate.swift
//  ContatosIP67
//
//  Created by ios8207 on 2/7/19.
//  Copyright © 2019 vargas. All rights reserved.
//

import Foundation

protocol FormularioContatoViewControllerDelegate{
    func contatoAtualizado(_ contato:Contato)
    func contatoAdicionado(_ contato:Contato)
}
