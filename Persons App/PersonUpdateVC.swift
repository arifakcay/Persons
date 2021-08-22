//
//  PersonUpdateVC.swift
//  Persons App
//
//  Created by admin on 20.08.2021.
//

import UIKit
import Alamofire
class PersonUpdateVC: UIViewController {

    @IBOutlet weak var personNameTextFieldUpdate: UITextField!
    @IBOutlet weak var phoneNumberTextFieldUpdate: UITextField!
    
    var person : Persons?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let p = person {
            personNameTextFieldUpdate.text = p.kisi_ad
            phoneNumberTextFieldUpdate.text = p.kisi_tel
        }
    }
    
    @IBAction func buttonUpdate(_ sender: Any) {
        if let p = person, let name = personNameTextFieldUpdate.text,let tel = phoneNumberTextFieldUpdate.text{
            personUpdate(kisi_id:p.kisi_id!,kisi_ad:name,kisi_tel:tel)
        }
    }
    
    func personUpdate(kisi_id:Int,kisi_ad:String,kisi_tel:String){
        let parameters:Parameters = ["kisi_id":kisi_id,"kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/update_kisiler.php",method: .post,parameters: parameters).responseJSON{
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
