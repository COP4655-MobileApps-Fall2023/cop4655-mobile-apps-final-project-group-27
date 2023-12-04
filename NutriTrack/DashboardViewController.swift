//
//  DashboardViewController.swift
//  NutriTrack
//
//  Created by Jovan Fuller on 11/22/23.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var CalorieCount: UITextField!
    
    @IBOutlet weak var CalorieProgress: UIProgressView!
    
    @IBOutlet weak var AddFoodButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
