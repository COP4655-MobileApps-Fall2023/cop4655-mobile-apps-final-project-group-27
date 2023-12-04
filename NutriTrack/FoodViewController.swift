import UIKit

class FoodViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    var foods: [Food] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodCell
        let food = foods[indexPath.row]
        cell.configure(with: food)
        return cell
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        fetchNutritionData(for: searchText)
    }

    private func fetchNutritionData(for query: String) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query=\(encodedQuery)") else {
                  print("Invalid URL or query")
                  return
        }
        print("Making API call to URL: \(url)")
        var request = URLRequest(url: url)
        request.setValue("XJjUAoJeFY5uofyt/xl8bg==FjwSc1CVBwCE2rUT", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("API call failed with error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Received no data from API")
                return
            }
            print("Received data: \(String(describing: String(data: data, encoding: .utf8)))")
            let decoder = JSONDecoder()
            do {
                let foods = try decoder.decode([Food].self, from: data)
                DispatchQueue.main.async {
                    self?.foods = foods
                    self?.tableView.reloadData()
                    // Assuming you want to show an alert for the first food item
                    if let firstFood = foods.first {
                        let message = "\(firstFood.name): \(firstFood.calories) calories"
                        self?.showAlertWithAddOption(message: message, food: firstFood)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.showAlertWithAddOption(message: "Error parsing JSON: \(error.localizedDescription)", food: Food(name: "", calories: 0))
                }
            }
        }
        task.resume()
    }

    private func showAlertWithAddOption(message: String, food: Food) {
        let alert = UIAlertController(title: "Food Information", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            self?.addFoodCalories(food)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    private func addFoodCalories(_ food: Food) {
        // Logic to add food calories to a different screen
        // This could involve updating a model, sending a notification, etc.
        // Example: self.performSegue(withIdentifier: "YourSegueIdentifier", sender: food)
        
        NotificationCenter.default.post(name: Notification.Name("AddCaloriesNotification"), object: nil, userInfo: ["calories": food.calories])
    }

    // Rest of your code...
}

// Food struct and any other necessary classes...
