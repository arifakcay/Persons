//
//  PersonDetailVC.swift
//  Persons App
//
//  Created by admin on 20.08.2021.
//

import UIKit

class PersonDetailVC: UIViewController {
    @IBOutlet weak var labelPersonName: UILabel!
    @IBOutlet weak var labelPersonPhoneNumber: UILabel!
    
    var person : Persons?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let p = person {
            labelPersonName.text = p.kisi_ad
            labelPersonPhoneNumber.text = p.kisi_tel
            
        }
    }
}
