//
//  RegViewController.swift
//  GB-Course-CleanCode
//
//  Created by Maksim Volkov on 04.08.2022.
//

import UIKit

class RegViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var creditcardTextField: UITextField!
    
    let registrationService = RegistrationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        scrollView.delegate = self
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    @IBAction func regButton(_ sender: UIButton) {
        guard passwordTextField.text == confirmPasswordTextField.text,
              username.text?.isEmpty == false,
              emailTextField.text?.isEmpty == false,
              passwordTextField.text?.isEmpty == false,
              creditcardTextField.text?.isEmpty == false,
              let username = username.text,
              let email = emailTextField.text?.lowercased(),
              let password = passwordTextField.text,
              let creditcard = creditcardTextField.text
        else { return }
        // на получение response установлено ожидание 2 секунды
        let response = registrationService.request(username: username, email: email, password: password, creditcard: creditcard)
        if response != "" {
            resumeRegistration(resume: response)
        } else {
            let alertController = UIAlertController(title: "Что-то пошло не так!", message: "Наверное плохое соединение с интернетом", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК", style: .default) { _ in}
            alertController.addAction(okAction)
            present(alertController, animated: true)
        }
    }
    
    func resumeRegistration(resume: String) {
        // создаем алертконтроллер, который будет появляется после отправки введенных данных на сервер
        let alertController = UIAlertController(title: "Попытка регистрации", message: resume, preferredStyle: .alert)
        // создаем кнопку "OK"
        let okAction = UIAlertAction(title: "Войти", style: .default) { _ in
            // после нажатия на кнопку ОК будет произведен переход на экран авторизации
            self.performSegue(withIdentifier: "afterReg", sender: self)
        }
        // добавляем кнопку ОК в алертконтроллер
        alertController.addAction(okAction)
        // презентуем алертконтроллер с анимацией
        present(alertController, animated: true)
    }
    
    
    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

}

// MARK: - UIScrollViewDelegate

extension RegViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0.0
    }
}

extension RegViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWasShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)

        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    @objc func keyBoardWasShow(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        // получаем размер клавиатуры
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        // для скрола добавляем расстояние, равное клаве
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyBoardWillBeHidden(notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}

