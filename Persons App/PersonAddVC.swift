//
//  PersonAddVC.swift
//  Persons App
//
//  Created by admin on 20.08.2021.
//

import UIKit
import Alamofire

class PersonAddVC: UIViewController {

    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func buttonAdd(_ sender: Any) {
        if let name = personNameTextField.text,let tel = phoneNumberTextField.text{
            personAdd(kisi_ad: name, kisi_tel: tel)
        }
    }
    
    func personAdd(kisi_ad:String,kisi_tel:String){
        let parameters:Parameters = ["kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
        
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php",method: .post,parameters: parameters).responseJSON{
            response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print(json)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
