//
//  ViewController.swift
//  Persons App
//
//  Created by admin on 20.08.2021.
//

import UIKit
import Alamofire
 
class ViewController: UIViewController {

    @IBOutlet weak var searcBar: UISearchBar!
    @IBOutlet weak var personsTableView: UITableView!
    
    var personsList = [Persons]()
    var makingCall = false
    var makingWord:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personsTableView.dataSource = self
        personsTableView.delegate = self

        searcBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if makingCall {
            doSearch(searchWord: makingWord!)
        }else{
            allPersonsGet()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toDetail" {
            let destinationVC = segue.destination as! PersonDetailVC
            destinationVC.person = personsList[indeks!]
    }
        
        if segue.identifier == "toUpdate" {
            let destinationVC = segue.destination as! PersonUpdateVC
            destinationVC.person = personsList[indeks!]
        }
    }
    
    func allPersonsGet(){
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php",method: .get).responseJSON{
            response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(PersonsResponse.self, from: data)
                    
                    if let comingPersonList = response.persons{
                        self.personsList = comingPersonList
                    }else{
                        self.personsList = [Persons]()
                    }
                    
                    DispatchQueue.main.async {
                        self.personsTableView.reloadData()
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func doSearch(searchWord:String){
        let parameters:Parameters = ["kisi_ad":searchWord]
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php",method: .post,parameters: parameters).responseJSON{
            response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(PersonsResponse.self, from: data)
                    
                    if let comingPersonList = response.persons{
                        self.personsList = comingPersonList
                    }else{
                        self.personsList = [Persons]()
                    }
                    
                    DispatchQueue.main.async {
                        self.personsTableView.reloadData()
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func personDelete(kisi_id:Int){
        let parameters:Parameters = ["kisi_id":kisi_id]
        Alamofire.request("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php",method: .post,parameters: parameters).responseJSON{
            response in
            if let data = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print(json)
                        
                        if self.makingCall {
                            self.doSearch(searchWord: self.makingWord!)
                        }else{
                            self.allPersonsGet()
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = personsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
        
        cell.labelPersonWrite.text = "\(person.kisi_ad!) - \(person.kisi_tel!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { ( contextualAction, view, boolValue) in
            let person = self.personsList[indexPath.row]
                self.personDelete(kisi_id: person.kisi_id!)
        }
        
        let UpdateAction = UIContextualAction(style: .normal, title: "Update") { ( contextualAction, view, boolValue) in
            self.performSegue(withIdentifier: "toUpdate", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction,UpdateAction])
    }
}

extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search Result : \(searchText)")
        makingWord = searchText
        
        if makingWord == ""{
            makingCall = false
        }else{
            makingCall = true
        }
        
        doSearch(searchWord: makingWord!)
    }
}

