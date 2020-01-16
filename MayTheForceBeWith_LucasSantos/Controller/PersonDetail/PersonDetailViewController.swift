//
//  PersonDetailViewController.swift
//  MayTheForceBeWith_LucasSantos
//
//  Created by Lucas  Felipe on 15/01/2020.
//  Copyright © 2020 Lucas  Felipe. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var hairColor: UILabel!
    @IBOutlet weak var skinColor: UILabel!
    @IBOutlet weak var eyeColor: UILabel!
    @IBOutlet weak var birthYear: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    
    var person: ApiPeople!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }

    private func configure() {
        self.name.text = self.person.name ?? ""
        self.height.text = "\(self.person.height ?? 0)"
        self.mass.text = "\(self.person.mass ?? 0)"
        self.hairColor.text = self.person.hairColor ?? ""
        self.skinColor.text = self.person.skinColor ?? ""
        self.eyeColor.text = self.person.eyeColor ?? ""
        self.birthYear.text = self.person.birthYear ?? ""
        self.gender.text = self.person.gender ?? ""
    }
}
