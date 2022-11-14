//
//  CartTableViewController.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 04.08.2022.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    let paybasketService = PayBasketService()
    var merchInCart = [String: Int]()
    var merch = [String]()
    var price = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        merchInCart.forEach { thing in
            merch.append(thing.key)
            price.append(thing.value)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return merchInCart.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cart", for: indexPath)

        
        cell.textLabel?.text = merch[indexPath.row]
        cell.detailTextLabel?.text = String(price[indexPath.row])

        return cell
    }
    
    @IBAction func payMerch(_ sender: UIBarButtonItem) {
        let response = paybasketService.request()
        if response != "" {
            resumepay(resume: response)
            merchInCart.removeAll()
            self.tableView.reloadData()
            
        } else {
            let alertController = UIAlertController(title: "Что-то пошло не так!", message: "Наверное плохое соединение с интернетом", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК", style: .default) { _ in}
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }
    }
    
    func resumepay(resume: String) {
        // создаем алертконтроллер, который будет появляется после отправки введенных данных на сервер
        let alertController = UIAlertController(title: "Попытка потратить деньги", message: resume, preferredStyle: .alert)
        // создаем кнопку "OK"
        let okAction = UIAlertAction(title: "Корзина пуста", style: .default) { _ in
        
        }
        // добавляем кнопку ОК в алертконтроллер
        alertController.addAction(okAction)
        // презентуем алертконтроллер с анимацией
        present(alertController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
