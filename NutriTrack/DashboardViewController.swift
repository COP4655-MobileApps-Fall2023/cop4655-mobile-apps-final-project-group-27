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
    
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetCalorieIntake()
    }
    
    private func resetCalorieIntake() {
        currentCalorieIntake = 0
        updateCalorieProgressDisplay()
        saveCurrentCalorieIntake()
    }
    
    private var dailyCaloricGoal: Double = 2000  // Default value; will be updated
    private var currentCalorieIntake: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserCaloricGoal()
        setupGradientView()
        NotificationCenter.default.addObserver(self, selector: #selector(handleCalorieAddition(_:)), name: Notification.Name("AddCaloriesNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileUpdated(_:)), name: Notification.Name("UserProfileUpdated"), object: nil)
    }
    
    @objc private func userProfileUpdated(_ notification: Notification) {
            fetchUserCaloricGoal()
        }

    

    @objc private func handleCalorieAddition(_ notification: Notification) {
        if let calories = notification.userInfo?["calories"] as? Double {
            currentCalorieIntake += calories
            updateCalorieProgressDisplay()
            saveCurrentCalorieIntake()
        }
    }

    private func fetchUserCaloricGoal() {
        if let currentUser = User.current {
            self.dailyCaloricGoal = currentUser.dailyCaloricGoal ?? 2000
            self.currentCalorieIntake = currentUser.currentCalorieIntake ?? 0
            updateCalorieProgressDisplay()
        } else {
            print("No current user found")
        }
    }

    private func updateCalorieProgressDisplay() {
        calorieCountTextField.text = "\(Int(currentCalorieIntake)) / \(Int(dailyCaloricGoal))"
        let progress = currentCalorieIntake / dailyCaloricGoal
        calorieProgressView.progress = Float(progress)
    }

    private func saveCurrentCalorieIntake() {
        if var currentUser = User.current {
            currentUser.currentCalorieIntake = currentCalorieIntake
            currentUser.save { result in
                switch result {
                case .success:
                    print("Current calorie intake updated successfully.")
                case .failure(let error):
                    print("Error updating calorie intake: \(error.localizedDescription)")
                }
            }
        }
    }

    private func setupGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        let startColor = UIColor(hex: "#DA6085").cgColor
        let endColor = UIColor(hex: "#D7EDE2").cgColor
        gradientLayer.colors = [startColor , endColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }

    @IBAction func addFoodButtonTapped(_ sender: Any) {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1 // Index of FoodViewController
        }
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
