//
//  MerchTableViewController.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 04.08.2022.
//

import UIKit

class MerchTableViewController: UITableViewController {
    var addToCart = AddToCartService()
    var deleteFromCartService = DeleteFromCartService()
    var merchInStock = StockService()
    var merch = [String]()
    var price = [Int]()
    var merchInCart = [String: Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        merchInStock.request()
        merchInStock.stockData.forEach { thing in
            merch.append(thing.key)
            price.append(thing.value)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func personalButton(_ sender: UIBarButtonItem) {
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return merchInStock.stockData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Merch", for: indexPath)

        
        cell.textLabel?.text = merch[indexPath.row]
        cell.detailTextLabel?.text = String(price[indexPath.row])

        return cell
    }
    

    // MARK: - leadingSwipeActionsConfigurationForRowAt
    
    // добавляем действие при свайпе ячейки слева направо
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let toCart = addToCart(at: indexPath)
        return UISwipeActionsConfiguration(actions: [toCart])
    }
    
    // MARK: - doneAction
    
    // создаем функцию для контекстной кнопки Done
    func addToCart (at indexPath: IndexPath) -> UIContextualAction {
        
        if merchInCart[merch[indexPath.row]] == nil {
            // сначала создадим объект типа UIContextualAction
            let action = UIContextualAction(style: .destructive, title: "incart") { (action, view, completion) in
                // добавляем в массив выбранный товар
                self.addToCart.request(merchname: self.merch[indexPath.row])
                self.merchInCart[self.merch[indexPath.row]] = self.price[indexPath.row]
                self.tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(systemName: "cart")
                completion(true)
            }
            action.backgroundColor = .systemGreen
            action.image = UIImage(systemName: "cart.badge.plus")
            return action
        } else {
            let unAction = UIContextualAction(style: .destructive, title: "outcart") { (action, view, completion) in
                // удаляем товар из корзины клиента
                self.deleteFromCartService.request(merchname: self.merch[indexPath.row])
                self.merchInCart.removeValue(forKey: self.merch[indexPath.row])
                
                self.tableView.cellForRow(at: indexPath)?.imageView?.image = nil
                completion(true)
            }
            unAction.image = UIImage(systemName: "cart.badge.minus")
            return unAction
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MerchViewController {
            guard
                let vc = segue.destination as? MerchViewController,
                let indexPathRow = tableView.indexPathForSelectedRow?.row
            else {
                return
            }
            print(merch)
            let merchName = merch[indexPathRow]

            vc.selectedMerchname = merchName
        } else if segue.destination is CartTableViewController {
            guard
                let vc = segue.destination as? CartTableViewController
                //let indexPathRow = tableView.indexPathForSelectedRow?.row
            else {
                return
            }
            print(merchInCart)
            vc.merchInCart = merchInCart
            merchInCart = [String: Int]()
            self.tableView.reloadData()
//            vc.price = price
//            vc.merch = merch
        }
    }
    

}
