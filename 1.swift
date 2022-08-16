//
//  ViewController.swift
//  NamesCompApp
//
//  Created by Danil Bochkarev on 16.08.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var youNameTF: UITextField!
    @IBOutlet weak var partnerNameTF: UITextField!
    
    //переход с 1 на 2 экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? ResultViewController else { return }
        //передача на 2 экран 2 имен
        dvc.firstName = youNameTF.text
        dvc.secondName = partnerNameTF.text
    }
    
    //resultButtonTapped
    
//    @IBAction func resultButtonTapped(_ sender: UIButton) {
//    }
    
    @IBAction func resultButtonTapped() {
        guard let firstName = youNameTF.text, let secondName = partnerNameTF.text else { return }
        
        //содержимое сообщения алерта
        if firstName.isEmpty || secondName.isEmpty {
            showAlert(
                title: "Names are missing",
                message: "Please enter both names 🤯"
            )
            return
        }
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    @IBAction func unwindSegueToFVC(segue: UIStoryboardSegue) {
        youNameTF.text = ""
        partnerNameTF.text = ""
    }
}


//расширение для алерта
extension ViewController {
    private func showAlert(title:String, message:String) {
        //содержимое алерта
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //кнопка ОК
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        //вызываем функцию
        present(alert, animated: true)
    }
}


extension ViewController: UITextFieldDelegate {
    //скрытие клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    //метод чтобы после написания в 1 тф, можно было на клавиатуре перести по кнопке next
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == youNameTF {
            partnerNameTF.becomeFirstResponder()
        }
        return true
    }
}

