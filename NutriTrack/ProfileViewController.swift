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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = User.current {
            profileName.text = currentUser.username
            
            // Do any additional setup after loading the view.
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
}
