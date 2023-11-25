//
//  FoodCell.swift
//  NutriTrack
//
//  Created by Dante Ricketts on 11/23/23.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var foodname: UILabel!
    
    @IBOutlet weak var foodcalorie: UILabel!
    
    func configure(with food: Food){
        foodname.text = food.name
        foodcalorie.text = String(food.calories)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
