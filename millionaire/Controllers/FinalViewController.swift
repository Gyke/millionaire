//
//  FinalViewController.swift
//  millionaire
//
//  Created by Михаил Позялов on 09.02.2023.
//

import UIKit

class FinalViewController: UIViewController {
    
    let musicEnd = AudioPlayer()
    
    var win: Int?
    var result: String?
  
    @IBOutlet weak var winAmount: UILabel!
    @IBOutlet weak var resultGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winAmount.text = String(win!)
        resultGameLabel.text = result

    }
    
    override func viewDidAppear(_ animated: Bool) {
        musicEnd.play(sound: "endOfGame")
    }
    
    @IBAction func playAgeinButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    
    @IBAction func backToMainButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let view = segue.destination as! GameViewController
            let millionaire = Millionaire(view: view, numberOfQuestion: 1, isHintTapped: [false, false, false])
            view.millionaire = millionaire
        } else if segue.identifier == "goToMain" {
//            let view = segue.destination as! StartViewController
//            TODO: Пофиксить воспроизведение музыки
        }
    }
}
