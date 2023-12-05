//
//  ViewController.swift
//  NutriTrack
//
//  Created by Dante Ricketts on 11/1/23.
//

import UIKit
import ParseSwift

class ViewController: UIViewController {

    @IBOutlet weak var username_field: UITextField!
    
    @IBAction func onLoginTapped(_ sender: Any) {
        guard let username = username_field.text,
              let password = password_field.text,
              !username.isEmpty,
              !password.isEmpty else{
            showMissingFieldsAlert()
            return
        }
        User.login(username:username, password: password){[weak self] result in
            switch result{
            case .success(let user):
                print("Sucessfully logged in as user: \(user)")
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    @IBOutlet weak var password_field: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    private func showAlert(description: String?) {
           let alertController = UIAlertController(title: "Unable to Log in", message: description ?? "Unknown error", preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .default)
           alertController.addAction(action)
           present(alertController, animated: true)
       }
    
    private func showMissingFieldsAlert() {
           let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to log you in.", preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .default)
           alertController.addAction(action)
           present(alertController, animated: true)
       }
}

