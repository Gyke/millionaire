//
//  ViewController.swift
//  millionaire
//
//  Created by Константин Стольников on 2023/02/05.
//

import UIKit

class StartViewController: UIViewController {
    
    
    let musicStart = AudioPlayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicStart.play(sound: "musical_intro")
        
        // Do any additional setup after loading the view.
    }
    
    
    

    @IBAction func rulesButtonPressed(_ sender: UIButton) {
        
        musicStart.stop()
        
        self.performSegue(withIdentifier: "goToRules", sender: self)
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        
        musicStart.stop()
        
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

