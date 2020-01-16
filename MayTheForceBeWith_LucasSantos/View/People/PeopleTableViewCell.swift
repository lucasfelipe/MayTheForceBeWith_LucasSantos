//
//  PeopleTableViewCell.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 15/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var birthYear: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(name: String) {
        self.name.text = name
    }
    
    func display(height: Double, mass: Double) {
        self.desc.text = "\(height)cm, \(mass)lbs"
    }
    
    func display(birthYear: String) {
        self.birthYear.text = birthYear
    }

}
