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
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var circularImageView: UIImageView!
    
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
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        // Set your hex color codes
        let startColor = UIColor(hex: "#DA6085").cgColor
        let endColor = UIColor(hex: "#D7EDE2").cgColor
        gradientLayer.colors = [startColor , endColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
        circularImageView.layer.cornerRadius = circularImageView.frame.size.width / 2
        circularImageView.clipsToBounds = true
        
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
extension UIColor{
    convenience init(hex: String) {
            var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

            var rgb: UInt64 = 0

            Scanner(string: hexSanitized).scanHexInt64(&rgb)

            let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgb & 0x0000FF) / 255.0

            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        }}

