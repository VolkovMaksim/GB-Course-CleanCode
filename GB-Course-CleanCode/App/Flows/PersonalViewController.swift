//
//  PersonalViewController.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 07.08.2022.
//

import UIKit

class PersonalViewController: UIViewController {

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var creditcardLabel: UILabel!
    @IBOutlet weak var creditcardTextField: UITextField!
    
    let editPersonalDataService = EditPersonalDataService()
    let currentUserData = CurrentUserData.instance
    var userData = [String : String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userDataInMemory = UserDefaults.standard.object(forKey: currentUserData.email!) as? [String : String] else { return }
        userData = userDataInMemory
        nameLabel.text = userData["username"]
        emailLabel.text = userData["email"]
        passwordLabel.text = userData["password"]
        creditcardLabel.text = userData["credit_card"]
        
        nameTextField.isHidden = !nameTextField.isHidden
        passwordTextField.isHidden = !passwordTextField.isHidden
        creditcardTextField.isHidden = !creditcardTextField.isHidden
    }
    

    @IBAction func editDataButton(_ sender: UIBarButtonItem) {
        editButton.title = "Готово"
        let name = nameLabel.text
        let password = passwordLabel.text
        let creditcard = creditcardLabel.text
        if nameTextField.isHidden == false {
            editButton.title = "Ред."
            if  nameTextField.text != "" {
                nameLabel.text = nameTextField.text
                userData["username"] = nameLabel.text
            }
            
            if  passwordTextField.text != "" {
                passwordLabel.text = passwordTextField.text
                userData["password"] = passwordLabel.text
            }
            
            if  creditcardTextField.text != "" {
                creditcardLabel.text = creditcardTextField.text
                userData["credit_card"] = creditcardLabel.text
            }
            let response = editPersonalDataService.request(username: userData["username"]!, email: currentUserData.email!, password: userData["password"]!, creditcard: userData["credit_card"]!)
            if response != "" {
                resumeEditPersonalData(resume: response)
            } else {
                nameLabel.text = name
                passwordLabel.text = password
                creditcardLabel.text = creditcard
                let alertController = UIAlertController(title: "Что-то пошло не так!", message: "Наверное плохое соединение с интернетом", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ОК", style: .default) { _ in}
                alertController.addAction(okAction)
                present(alertController, animated: true)
            }
        }
        
        nameTextField.text = ""
        passwordTextField.text = ""
        creditcardTextField.text = ""
        
        nameTextField.isHidden = !nameTextField.isHidden
        passwordTextField.isHidden = !passwordTextField.isHidden
        creditcardTextField.isHidden = !creditcardTextField.isHidden
        nameLabel.isHidden = !nameLabel.isHidden
        passwordLabel.isHidden = !passwordLabel.isHidden
        creditcardLabel.isHidden = !creditcardLabel.isHidden
        
        
    }
    
    func resumeEditPersonalData(resume: String) {
        // создаем алертконтроллер, который будет появляется после отправки введенных данных на сервер
        let alertController = UIAlertController(title: "Попытка редактирования", message: resume, preferredStyle: .alert)
        // создаем кнопку "OK"
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
            switch resume {
            case "Данные изменены успешно!":
                return
            default:
                return
            }
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
