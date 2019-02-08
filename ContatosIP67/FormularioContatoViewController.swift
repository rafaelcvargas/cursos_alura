//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 2/5/19.
//  Copyright © 2019 vargas. All rights reserved.
//

import UIKit

class FormularioContatoViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    var delegate:FormularioContatoViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contato != nil{
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            
            if let foto = self.contato.foto{
                self.imageView.image = self.contato.foto
            }
            
            let botaoAlterar = UIBarButtonItem(title:"Confirmar",style:.plain,target:self,action: #selector(atualizaContato))
            
            self.navigationItem.rightBarButtonItem = botaoAlterar
        
          }
        let tap = UITapGestureRecognizer(target: self, action: #selector(selecionarFoto(sender:)))
        self.imageView.addGestureRecognizer(tap)

        
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
        
        self.contato.foto = self.imageView.image
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
    
    func selecionarFoto(sender: AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //camera disponivel
        }else{
            //usar biblioteca
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let imagemSelecionada = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.imageView.image = imagemSelecionada
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        }
  
}

