//
//  ViewController.swift
//  millionaire
//
//  Created by Константин Стольников on 2023/02/05.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func rulesButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToRules", sender: self)
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
}

