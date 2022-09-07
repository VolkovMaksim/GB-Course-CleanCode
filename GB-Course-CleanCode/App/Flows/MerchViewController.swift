//
//  MerchViewController.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 04.08.2022.
//

import UIKit

class MerchViewController: UIViewController {

    @IBOutlet weak var merchname: UILabel!
    @IBOutlet weak var merchprice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedMerchname = ""
    var currentMerch = MerchService()
    var merchFeedbackArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        merchname.text = selectedMerchname
        currentMerch.request(merchname: merchname.text ?? "")
        merchprice.text = String(currentMerch.merchAndPrice) + " рублей"
        currentMerch.merchAndFeedback.forEach { thing in
            merchFeedbackArray.append(thing)
        }
        print(merchFeedbackArray)
        // Do any additional setup after loading the view.
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

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MerchViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchFeedbackArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Feedback", for: indexPath)
        
        cell.textLabel?.text = merchFeedbackArray[indexPath.row]
        

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            merchFeedbackArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
