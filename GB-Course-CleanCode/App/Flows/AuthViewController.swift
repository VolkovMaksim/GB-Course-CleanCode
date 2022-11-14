//
//  AuthViewController.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 04.08.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let authorizationService = AuthorizationService()
    
    var currentUserData = CurrentUserData.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func enterButton(_ sender: UIButton) {
        guard emailTextField.text?.isEmpty == false,
              passwordTextField.text?.isEmpty == false,
              let email = emailTextField.text?.lowercased(),
              let password = passwordTextField.text
        else { return }
        // на получение response установлено ожидание 1 секунды
        let response = authorizationService.request(email: email, password: password)
        if response != "" {
            currentUserData.email = emailTextField.text
            resumeAuthorization(resume: response)
        } else {
            let alertController = UIAlertController(title: "Что-то пошло не так!", message: "Наверное плохое соединение с интернетом", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК", style: .default) { _ in}
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }
    }
    
    func resumeAuthorization(resume: String) {
        // создаем алертконтроллер, который будет появляется после отправки введенных данных на сервер
        let alertController = UIAlertController(title: "Попытка Авторизации", message: resume, preferredStyle: .alert)
        // создаем кнопку "OK"
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
            switch resume {
            case "Успешная авторизация!":
                // после нажатия на кнопку ОК будет произведен переход на экран магазина
                self.performSegue(withIdentifier: "afterAuth", sender: self)
            case "Такой E-mail не зарегистрирован":
                return
            case "Неправильный пароль!":
                return
            default:
                return
            }
            // после нажатия на кнопку ОК будет произведен переход на экран магазина
            //self.performSegue(withIdentifier: "afterAuth", sender: self)
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
