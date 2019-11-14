//
//  MainTableViewController.swift
//  PhoneBook
//
//  Created by Дарья Хомякова on 12.11.2019.
//  Copyright © 2019 Дарья Хомякова. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    @IBOutlet weak var contactLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    // Если секция одна, то не обязательно переобределять numberOfSections,
    // потому что по умолчанию и так возвращается 1
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ContactArray.contacts.count == 0{
            return 1
        }else{
            // Тут достаточно возвращать кол-во контактов и нет
            // смысла обрабатывать ситуации, когда контактов 0.
            // Пусть возвращается 0 и тогда у таблицы просто
            // не будет ячеек
            return ContactArray.contacts.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Лучше сортировку делать при измненении ContactArray.contacts
        // Потому что иначе эта сотировка у тебя выполняется каждый раз
        // при получении новой ячейки, а если будет много данных, то это
        // сильно скажется на плавности работы интерфейса и FPS просядет
        ContactArray.contacts = ContactArray.contacts.sorted(by: { (s1: Contact, s2:Contact) -> Bool in
            return s1.name < s2.name
        })
        
        // Проверка по-сути не нужна, просто вытаскиваем контакт по indexPath.
        // Если на этом этапе будет какая-то ошибка, то пусть уж приложение упадёт
        // и мы эту ошибку сразу увидим
        if ContactArray.contacts.count > 0{
            cell.textLabel?.text = ContactArray.contacts[indexPath.row].name
        }
        return cell
    }

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        guard let addContactVC = segue.source as? AddContactVC else { return }
        addContactVC.saveNew()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContact"{
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let pickedContact = ContactArray.contacts[indexPath.row]
            let editContactVC = segue.destination as! AddContactVC
            editContactVC.pickedContact = pickedContact
            editContactVC.pickedContactIndex = indexPath.row
        }
    }
    
    // Нет смысла оставлять закомменченный и неиспользуемый код
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
