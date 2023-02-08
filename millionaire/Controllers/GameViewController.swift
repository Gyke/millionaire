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
    
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionMoneyLabel: UILabel!
    
    var millionaire: MillionaireProtocol!
    
    let money: [Int] = [100, 200, 300, 400, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 125000, 250000, 500000, 1000000]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        millionaire.setQuestion()
        
    }
    
    @IBAction func answerTapped(_ sender: UIButton) {
        for tag in 1...4 {
            if sender.tag == tag {
                sender.setBackgroundImage( UIImage(named: "Rectangle purple") , for: .normal)
        
                answerOneButton.isUserInteractionEnabled = false
                answerTwoButton.isUserInteractionEnabled = false
                answerThreeButton.isUserInteractionEnabled = false
                answerFourButton.isUserInteractionEnabled = false
                
                millionaire.answerTapped(answer: millionaire.question.answerOptions[tag - 1], numberOfAnswer: tag)
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
        questionNumberLabel.text = "Question: \(millionaire.numberOfQuestion)"
        questionMoneyLabel.text = "\(money[millionaire.numberOfQuestion - 1]) RUB"
    }
    
    func success(numberOfQuestion: Int, numberOfAnswer: Int) {
        
        //проигрываем музыку правильного ответа
        
        setButtonBackground(answerNumber: numberOfAnswer, colour: .green)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.performSegue(withIdentifier: "goToResult", sender: self)
        })
        
    }
    
    func failure(numberOfQuestion: Int, numberOfAnswer: Int) {
        
        //проигрываем музыку в случае неудачи
        
        setButtonBackground(answerNumber: numberOfAnswer, colour: .red)
        
        if let index = millionaire.question.answerOptions.firstIndex(where: {$0 == millionaire.question.answer}) {
            setButtonBackground(answerNumber: index + 1, colour: .green)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.performSegue(withIdentifier: "goToResult", sender: self)
        })
        
    }
    
    func setButtonBackground(answerNumber: Int, colour: ButtonColor) {
        switch answerNumber {
        case 1:
            answerOneButton.setBackgroundImage(colour.image, for: .normal)
        case 2:
            answerTwoButton.setBackgroundImage(colour.image, for: .normal)
        case 3:
            answerThreeButton.setBackgroundImage(colour.image, for: .normal)
        case 4:
            answerFourButton.setBackgroundImage(colour.image, for: .normal)
        default:
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let view = segue.destination as! ScoreTableViewController
            view.questionNumber = millionaire.numberOfQuestion
            view.answerResult = millionaire.answerResult
        }
    }
    
}
