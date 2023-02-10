//
//  FinalViewController.swift
//  millionaire
//
//  Created by Михаил Позялов on 09.02.2023.
//

import UIKit

class FinalViewController: UIViewController {
    
    var win: Int?
    var result: String?
  
    @IBOutlet weak var winAmount: UILabel!
    @IBOutlet weak var resultGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winAmount.text = String(win!)
        resultGameLabel.text = result

    }
    
    @IBAction func playAgeinButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let view = segue.destination as! GameViewController
            let millionaire = Millionaire(view: view, numberOfQuestion: 1, isHintTapped: [false, false, false])
            view.millionaire = millionaire
        }
    }
}
