//
//  ViewController.swift
//  mvvmPractice
//
//  Created by Felipe Gil on 2021-07-19.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var username: BoundTextField!
    var user = User(name: Observable("Felipe Gil"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.bind(to: user.name)
    }


}

