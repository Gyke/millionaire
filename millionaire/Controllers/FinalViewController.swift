//
//  FinalViewController.swift
//  millionaire
//
//  Created by Михаил Позялов on 09.02.2023.
//

import UIKit

class FinalViewController: UIViewController {
    //Экземпляр плеера
    let musicEnd = AudioPlayer()
    //Для постоянного воспроизведения
    func playMusic(loop: Bool) {
        musicEnd.play(sound: "endOfGame")
            if loop {
                musicEnd.player?.numberOfLoops = -1
            }
        }
    
    var win: Int?
    var result: String?
  
    @IBOutlet weak var winAmount: UILabel!
    @IBOutlet weak var resultGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winAmount.text = String(win ?? 0)
        resultGameLabel.text = result

    }
    
    override func viewDidAppear(_ animated: Bool) {
        playMusic(loop: true)
    }
    
    @IBAction func playAgeinButtonPressed(_ sender: UIButton) {
        
        musicEnd.stop()
        
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    
    @IBAction func backToMainButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToMain", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        musicEnd.stop()
        if segue.identifier == "goToGame" {
            let view = segue.destination as! GameViewController
            let millionaire = Millionaire(view: view, numberOfQuestion: 1, isHintTapped: [false, false, false])
            view.millionaire = millionaire
        }
    }
}
