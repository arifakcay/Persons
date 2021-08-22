//
//  Persons.swift
//  Persons App
//
//  Created by admin on 21.08.2021.
//

import Foundation
class Persons:Codable {
    var kisi_id:Int?
    var kisi_ad:String?
    var kisi_tel:String?
    
    init(kisi_id:Int,kisi_ad:String,kisi_tel:String) {
        self.kisi_id = kisi_id
        self.kisi_ad = kisi_ad
        self.kisi_tel = kisi_tel
    }
}
