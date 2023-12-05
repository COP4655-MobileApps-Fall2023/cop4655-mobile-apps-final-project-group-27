//
//  CreateProfileViewController.swift
//  NutriTrack
//
//  Created by Christian Allbright on 12/3/23.
//

import UIKit

class CreateProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 1 ? genders.count : heights.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView.tag == 1 {
                // Return the appropriate title for genderPicker rows
                return genders[row]
            } else if pickerView.tag == 2 {
                // Return the appropriate title for heightPicker rows
                return heights[row]
            }
            return nil
        }

    @IBOutlet weak var genderPicker: UIPickerView!

    @IBOutlet weak var heightPicker: UIPickerView!
 
  
    @IBOutlet weak var currentWeightTextField: UITextField!
    
    
    @IBOutlet weak var goalWeightTextField: UITextField!
    
    @IBOutlet var gradientView: UIView!
    
  
    @IBOutlet weak var ageTextField: UITextField!
    let genders = ["Male", "Female"]
    let heights: [String] = (48...96).map { "\($0 / 12)'\($0 % 12)\"" } // Heights from 4'0" to 8'0"

    override func viewDidLoad() {
        super.viewDidLoad()
        genderPicker.tag = 1
        heightPicker.tag = 2
        genderPicker.delegate = self
        genderPicker.dataSource = self
        heightPicker.delegate = self
        heightPicker.dataSource = self
        // Additional setup...
        
        
        //gradient code
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

    @IBAction func submitProfileDetails(_ sender: UIButton) {
            let genderIndex = genderPicker.selectedRow(inComponent: 0)
            let heightIndex = heightPicker.selectedRow(inComponent: 0)
            let currentWeight = Double(currentWeightTextField.text ?? "") ?? 0
            let goalWeight = Double(goalWeightTextField.text ?? "") ?? 0
            let age = Int(ageTextField.text ?? "") ?? 0

            let gender = genders[genderIndex]
            let height = heights[heightIndex]

            if var currentUser = User.current {
                currentUser.gender = gender
                currentUser.height = height
                currentUser.currentWeight = currentWeight
                currentUser.goalWeight = goalWeight
                currentUser.age = age
                
                let dailyCaloricGoal = currentUser.dailyCaloricGoal
                
                currentUser.save { result in
                    switch result {
                    case .success:
                        print("User profile updated successfully. Daily Caloric Goal: \(dailyCaloricGoal ?? 0)")
                        // Navigate to another view or show success message
                    case .failure(let error):
                        print("Error updating user: \(error.localizedDescription)")
                        // Show error message
                    }
                }
            }
        
        self.dismiss(animated: true, completion: nil)
        }

   

    // UIPickerView DataSource and Delegate methods...
    // Implement other required methods and logic...
}
