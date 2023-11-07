//
//  SignUpViewController.swift
//  NutriTrack
//
//  Created by Dante Ricketts on 11/6/23.
//

import UIKit
import ParseSwift

class SignUpViewController: UIViewController {

    @IBOutlet weak var Email_Field: UITextField!
    @IBOutlet weak var Username_Field: UITextField!
    @IBOutlet weak var Password_Field: UITextField!
    
    @IBAction func SignUp_Button(_ sender: Any) {
        guard let username = Username_Field.text,
              let email = Email_Field.text,
              let password = Password_Field.text,
              !username.isEmpty,
              !email.isEmpty,
              !password.isEmpty else{
            showMissingFieldsAlert()
            return
        }
        var newUser = User()
        newUser.username = username
        newUser.email = email
        newUser.password = password
        newUser.signup{ [weak self] result in
            switch result{
            case .success(let user):
                print("✅ Successfully signed up user \(user)")
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
            case .failure(let error):
                
                self?.showAlert(description: error.localizedDescription)
                
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    private func showAlert(description: String?) {
          let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "Unknown error", preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default)
          alertController.addAction(action)
          present(alertController, animated: true)
      }

      private func showMissingFieldsAlert() {
          let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default)
          alertController.addAction(action)
          present(alertController, animated: true)
      }
}
