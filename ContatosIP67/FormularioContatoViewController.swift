//
//  ViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 2/5/19.
//  Copyright © 2019 vargas. All rights reserved.
//

import UIKit
import CoreLocation

class FormularioContatoViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    var delegate:FormularioContatoViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nome:UITextField!
    @IBOutlet weak var telefone:UITextField!
    @IBOutlet weak var endereco:UITextField!
    @IBOutlet weak var site:UITextField!
    @IBOutlet weak var latitude:UITextField!
    @IBOutlet weak var longitude:UITextField!
    @IBOutlet weak var loading:UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contato != nil{
            self.nome.text = contato.nome
            self.telefone.text = contato.telefone
            self.endereco.text = contato.endereco
            self.site.text = contato.site
            self.longitude.text = contato.longitude?.description
            self.latitude.text = contato.latitude?.description
            
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
    
    
    
    func pegarDadosDoFormulario(){
        if contato == nil{
            self.contato = dao.novoContato()
        }
        
        
        self.contato.foto = self.imageView.image
        self.contato.nome = self.nome.text!
        self.contato.telefone = self.telefone.text!
        self.contato.endereco = self.endereco.text!
        self.contato.site = self.site.text!
        
        if let latitude = Double(self.latitude.text!){
            self.contato.latitude = latitude as NSNumber
        }
        
        if let longitude = Double(self.longitude.text!){
            self.contato.longitude = longitude as NSNumber
        }
        
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
    
        
    @IBAction func buscaCoordenadas(sender: UIButton){
        
        if endereco.text != ""{
        
            self.loading.startAnimating()
            sender.isEnabled = false
            let geocoder = CLGeocoder()
        
            geocoder.geocodeAddressString(self.endereco.text!){(resultado, error) in
                if error == nil && (resultado?.count)! > 0 {
                    let placemark = resultado![0]
                    let coordenada = placemark.location!.coordinate
                
                    self.latitude.text = coordenada.latitude.description
                    self.longitude.text = coordenada.longitude.description
                }
                self.loading.stopAnimating()
                sender.isEnabled = true
            }
        }else{
            let alert = UIAlertController(title: "Preencher o endereco primeiro", message: "Endereco em branco", preferredStyle: .alert)
            
            let acao = UIAlertAction(title:
                "OK", style: .default, handler:
                nil)
            
            alert.addAction(acao)
            //continuar depois
            //self.controller.present(alert, animated: true, completion: nil)
        }
    }
  
}

