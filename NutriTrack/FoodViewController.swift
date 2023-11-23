//
//  FoodViewController.swift
//  NutriTrack
//
//  Created by Dante Ricketts on 11/23/23.
//

import UIKit

class FoodViewController: UIViewController, UITableViewDataSource {
    
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
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
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    <#code#>
}
