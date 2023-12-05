//
//  DashboardViewController.swift
//  NutriTrack
//
//  Created by Jovan Fuller on 11/22/23.
//

import UIKit
import ParseSwift

class DashboardViewController: UIViewController {

    
    @IBOutlet weak var calorieCountTextField: UITextField!
    
    @IBOutlet var gradientView: UIView!
    
    @IBOutlet weak var calorieProgressView: UIProgressView!
    
    private var dailyCaloricGoal: Double = 2000  // Default value; will be updated
    private var currentCalorieIntake: Double = 0
    
    
   
    
    @IBAction func addFoodButtonTapped(_ sender: Any) {
        
        if let tabBarController = self.tabBarController {
                    tabBarController.selectedIndex = 1 // Index of FoodViewController
                }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserCaloricGoal()

        NotificationCenter.default.addObserver(self, selector: #selector(handleCalorieAddition(_:)), name: Notification.Name("AddCaloriesNotification"), object: nil)
        // Do any additional setup after loading the view.
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        // Set your hex color codes
        let startColor = UIColor(hex: "#DA6085").cgColor
        let endColor = UIColor(hex: "#D7EDE2").cgColor
        gradientLayer.colors = [startColor , endColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)

    }
    
    
    @objc private func handleCalorieAddition(_ notification: Notification) {
            if let calories = notification.userInfo?["calories"] as? Double {
                currentCalorieIntake += calories
                updateCalorieProgressDisplay()
            }
        }
    
    private func fetchUserCaloricGoal() {
            // Assuming you have a custom User struct that conforms to ParseUser
            if let currentUser = User.current {
                // Fetch the daily caloric goal from the currentUser
                self.dailyCaloricGoal = currentUser.dailyCaloricGoal ?? 2000
                // You can now update the UI with this value
                updateCalorieProgressDisplay()
            } else {
                print("No current user found")
                // Handle the scenario when there's no logged-in user
            }
        }
    
    private func updateCalorieProgressDisplay() {
           // Update the text field to show "current intake / daily goal"
           calorieCountTextField.text = "\(Int(currentCalorieIntake)) / \(Int(dailyCaloricGoal))"

           // Calculate the progress as a fraction and update the progress bar
           let progress = currentCalorieIntake / dailyCaloricGoal
           calorieProgressView.progress = Float(progress)
       }
    
    
    
    
    
    
    
    @IBAction func onLogOutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }
    
    
    private func showConfirmLogoutAlert() {
            let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
            let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
                NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(logOutAction)
            alertController.addAction(cancelAction)
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
