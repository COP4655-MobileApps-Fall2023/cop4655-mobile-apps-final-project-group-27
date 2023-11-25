//
//  FoodViewController.swift
//  NutriTrack
//
//  Created by Dante Ricketts on 11/23/23.
//

import UIKit

class FoodViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodCell
        let food = foods[indexPath.row]
        cell.configure(with: food)
        return cell
        
    }
    
    
    
    var foods: [Food] = []
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=brisket")!
        let request = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request){ [weak self] data, response, error in
            
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            guard let data = data else{
                print("❌ Data is nil")
                return
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(FoodsResponse.self, from: data)
                let foods = response.results
                DispatchQueue.main.async {
                    self?.foods = foods
                    self?.tableView.reloadData()
                }
                
            }catch{
                print("❌ Error parsing JSON: \(error.localizedDescription)")
                
            }
        }
        task.resume()
        print(foods)
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

