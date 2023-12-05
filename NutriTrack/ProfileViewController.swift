//
//  ProfileViewController.swift
//  NutriTrack
//
//  Created by Jovan Fuller on 11/22/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileName: UITextField!
    
    @IBOutlet weak var CalorieGoalField: UITextField!
    
    @IBOutlet var gradientView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = User.current {
            profileName.text = currentUser.username
            
            // Do any additional setup after loading the view.
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        // Set your hex color codes
        let startColor = UIColor(hex: "#DA6085").cgColor
        let endColor = UIColor(hex: "#D7EDE2").cgColor
        gradientLayer.colors = [startColor , endColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)

        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
