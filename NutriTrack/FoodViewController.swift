import UIKit

class FoodViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    // Your existing properties
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
        // Your existing implementation
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
                        let foods = try JSONDecoder().decode([Food].self, from: data)
                        
                        // Construct a message with the results
                        var resultsMessage = "Search Results:\n"
                        for food in foods {
                            resultsMessage += "\(food.name): \(food.calories) calories\n"
                        }

                        DispatchQueue.main.async {
                            self?.foods = foods
                            self?.tableView.reloadData()

                            // Show the results in an alert
                            self?.showAlert(message: resultsMessage)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self?.showAlert(message: "Error parsing JSON: \(error.localizedDescription)")
                        }
                    }
                }
                task.resume()
            }

            private func showAlert(message: String) {
                let alert = UIAlertController(title: "Search Results", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
    


    // Rest of your code
}
