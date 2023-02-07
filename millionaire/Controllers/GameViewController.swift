//
//  GameViewController.swift
//  millionaire
//
//  Created by Владимир Смирнов on 06.02.2023.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOne: UILabel!
    @IBOutlet weak var answerTwo: UILabel!
    @IBOutlet weak var answerThree: UILabel!
    @IBOutlet weak var answerFour: UILabel!
    
    var millionaire: MillionaireProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        millionaire.setQuestion()
        
        
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        for tag in 1...4 {
            if sender.tag == tag {
                millionaire.answerTapped(answer: millionaire.question.answerOptions[tag - 1])
            }
        }
    }

}

extension GameViewController: MillionaireViewProtocol {
    func setQuestion(question: Question) {
        questionLabel.text = question.text
        answerOne.text = question.answerOptions[0]
        answerTwo.text = question.answerOptions[1]
        answerThree.text = question.answerOptions[2]
        answerFour.text = question.answerOptions[3]
    }
    
    func success() {
        
    }
    
    func failure() {
        
    }
    
    
}
