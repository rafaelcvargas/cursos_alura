//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 2/5/19.
//  Copyright © 2019 vargas. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController {

    var delegate:FormularioContatoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contato != nil{
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            
            let botaoAlterar = UIBarButtonItem(title:"Confirmar",style:.plain,target:self,action: #selector(atualizaContato))
            self.navigationItem.rightBarButtonItem = botaoAlterar
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var dao:ContatoDao
    var contato: Contato!
    
    required init?(coder aDecoder: NSCoder){
        self.dao = ContatoDao.sharedInstance()
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var nome:UITextField!
    @IBOutlet weak var telefone:UITextField!
    @IBOutlet weak var endereco:UITextField!
    @IBOutlet weak var site:UITextField!
    
    func pegarDadosDoFormulario(){
        if contato == nil{
            self.contato = Contato()
        }
        
        self.contato.nome = self.nome.text!
        self.contato.telefone = self.telefone.text!
        self.contato.endereco = self.endereco.text!
        self.contato.site = self.site.text!
    }
    
    @IBAction func criarContato(){
        self.pegarDadosDoFormulario()
        dao.adiciona(contato)
        self.delegate?.contatoAdicionado(contato)
        _=self.navigationController?.popViewController(animated: true)
        
        
        
        //print(contato)
    }
    
    func atualizaContato(){
        pegarDadosDoFormulario()
        self.delegate?.contatoAtualizado(contato)
        _ = self.navigationController?.popViewController(animated: true)
    }
  
}

