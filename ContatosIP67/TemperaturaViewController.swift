//
//  TemperaturaViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 2/13/19.
//  Copyright © 2019 vargas. All rights reserved.
//

import UIKit

class TemperaturaViewController: UIViewController {
    
    @IBOutlet weak var labelCondicaoAtual: UILabel!
    @IBOutlet weak var labelTemperaturaMaxima: UILabel!
    @IBOutlet weak var labelTemperaturaMinima: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Outlets para modo Size Classes
    @IBOutlet weak var labelNomeContato: UILabel!
    @IBOutlet weak var labelEnderecoContato: UILabel!
    
    var contato:Contato?
    
    
    let URL_BASE = "https://api.openweathermap.org/data/2.5/weather?APPID=2ebcc72ac5520fbf01a350393b36edf6&units=metric"
    
    let URL_BASE_IMAGE = "https://openweathermap.org/img/w/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cria notificação para detectar mudança de orientação em tempo real
        NotificationCenter.default.addObserver(self, selector: #selector(TemperaturaViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        orientationChanged()

        // Do any additional setup after loading the view.
        
        if let contato = self.contato{
            if let endpoint = URL(string: URL_BASE + "&lat=\(contato.latitude ?? 0)&lon=\(contato.longitude ?? 0)"){
                print (endpoint)
                let session = URLSession(configuration: .default)
                
                let task = session.dataTask(with: endpoint){(data,response,error) in
                    if let httpResponse = response as? HTTPURLResponse{
                        if httpResponse.statusCode == 200 {
                            
                            do{
                                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]{
                                    
                                    let main = json["main"] as! [String:AnyObject]
                                    let weather = json["weather"]![0] as! [String:AnyObject]
                                    let temp_min = main["temp_min"] as! Double
                                    let temp_max = main["temp_max"] as! Double
                                    let icon = weather["icon"] as! String
                                    let condicao = weather["main"] as! String
                                
                                    DispatchQueue.main.async {
                                        print(condicao)
                                        print(temp_min)
                                        print(temp_max)
                                        print(icon)
                                        
                                        self.labelCondicaoAtual.text = condicao
                                        self.labelTemperaturaMinima.text = temp_min.description + "º"
                                        self.labelTemperaturaMaxima.text = temp_max.description + "º"
                                        self.pegaImagem(icon)
                                        
                                        self.labelCondicaoAtual.isHidden = false
                                        self.labelTemperaturaMinima.isHidden = false
                                        self.labelTemperaturaMaxima.isHidden = false
                                    }
                                    
                                }
                            }catch let error as NSError{
                                print("Nao foi possivel fazer o parser do JSON: \(error.localizedDescription)")
                            }
                        }else{
                            print("A requisicao nao foi bem sucedida: \(error?.localizedDescription)")
                        }
                    }
                }
                
                task.resume()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func pegaImagem(_ icon:String){
        if let endpoint = URL(string: URL_BASE_IMAGE + icon + ".png"){
            print(endpoint)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: endpoint){(data,response,error) in
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        DispatchQueue.main.async {
                            print("Exibindo Imagem")
                            self.imageView.image = UIImage(data: data!)
                        }
                    }
                }
            }
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func orientationChanged() {
        // Verifica ambiente (size classes)
        // Carrega campos de contato apenas se estivermos num ambiente wR (Plus e iPads em landscape)
        if sizeClass() == (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.compact) {
            labelNomeContato.text = contato?.nome
            labelEnderecoContato.text = contato?.endereco
        }
    }

}

// Extensão para retornar ambiente de size classes
extension UIViewController {
    func sizeClass() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
        return(traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass)
    } }
