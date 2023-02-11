//
//  GameViewController.swift
//  millionaire
//
//  Created by Владимир Смирнов on 06.02.2023.
//

import UIKit


class GameViewController: UIViewController {
    
    

    let musicGame = AudioPlayer()
    

    //MARK: - IBOutlets
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOne: UILabel!
    @IBOutlet weak var answerTwo: UILabel!
    @IBOutlet weak var answerThree: UILabel!
    @IBOutlet weak var answerFour: UILabel!
    
    @IBOutlet weak var answerOneButton: UIButton!
    @IBOutlet weak var answerTwoButton: UIButton!
    @IBOutlet weak var answerThreeButton: UIButton!
    @IBOutlet weak var answerFourButton: UIButton!
    @IBOutlet weak var getPrizeButton: UIButton!

    @IBOutlet weak var answerOneOutletView: UIView!
    @IBOutlet weak var answerTwoOutletView: UIView!
    @IBOutlet weak var answerThreeOutletView: UIView!
    @IBOutlet weak var answerFourOutletView: UIView!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionMoneyLabel: UILabel!
    
    @IBOutlet weak var fiftyCloseView: UIView!
    @IBOutlet weak var hallCloseView: UIView!
    @IBOutlet weak var friendCloseView: UIView!
    
    @IBOutlet weak var fiftyButton: UIButton!
    @IBOutlet weak var hallButton: UIButton!
    @IBOutlet weak var friendButton: UIButton!
    
    //MARK: - Variables
    
    
    var timer = Timer()
    var totalTime = 30
    
    var millionaire: MillionaireProtocol!
    
    let money: [Int] = [100, 200, 300, 400, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 125000, 250000, 500000, 1000000]
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        millionaire.setQuestion()
        
    }
    //MARK: - ViewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        musicGame.play(sound: "zvuk-fon")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer),userInfo: nil, repeats: true)
    }
    
    //MARK: - IBActions
    
    @IBAction func answerTapped(_ sender: UIButton) {
        
        //Музака напряженная перед ответом
        musicGame.play(sound: "zvuk-napryajeniya-pered-otv")
        
        for tag in 1...4 {
            if sender.tag == tag {
                sender.setBackgroundImage( UIImage(named: "Rectangle purple") , for: .normal)
                
                //Деактивизация кнопок подсказок
                fiftyButton.isEnabled = false
                hallButton.isEnabled = false
                friendButton.isEnabled = false
                getPrizeButton.isEnabled = false
                //Деактивизация кнопок вариантов ответов
                answerOneButton.isUserInteractionEnabled = false
                answerTwoButton.isUserInteractionEnabled = false
                answerThreeButton.isUserInteractionEnabled = false
                answerFourButton.isUserInteractionEnabled = false
                
                millionaire.answerTapped(answer: millionaire.question.answerOptions[tag - 1], numberOfAnswer: tag)
            }
        }
        timer.invalidate()
    }
    
    @IBAction func getPrizeButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        musicGame.stop()
        self.performSegue(withIdentifier: "goToFinish", sender: self)
    }
    
    @IBAction func hintButtonTapped(_ sender: UIButton) {
        
        //Музыка подсказки
        musicGame.play(sound: "podskazka-50-na-50")
        //Запуск музыки для размышления
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.musicGame.play(sound: "reflectionTime")
            }
        
        
        switch sender.tag {
        case 1:
            fiftyCloseView.alpha = 1
            fiftyButton.isUserInteractionEnabled = false
            let percentage = millionaire.hintTapped(hintType: .hintFifty)
            if percentage[0] == 0 { answerOneOutletView.alpha = 0 ; answerOneButton.isUserInteractionEnabled = false}
            if percentage[1] == 0 { answerTwoOutletView.alpha = 0 ; answerOneButton.isUserInteractionEnabled = false}
            if percentage[2] == 0 { answerThreeOutletView.alpha = 0 ; answerOneButton.isUserInteractionEnabled = false}
            if percentage[3] == 0 { answerFourOutletView.alpha = 0 ; answerOneButton.isUserInteractionEnabled = false}
            
        case 2:
            return
        case 3:
            return
        default:
            return
        }
    }
    
    //MARK: - Methods

    @objc func updateTimer() {
        if totalTime != 0 {
            totalTime -= 1
            timerLabel.text = String(totalTime)
            if totalTime <= 5 {
                timerLabel.textColor = .red
            }
        } else {
            timer.invalidate()
            musicGame.stop()
            self.performSegue(withIdentifier: "goToFinish", sender: self)
        }
        
    }

}

//MARK: - Extensions

extension GameViewController: MillionaireViewProtocol {
   
    func setQuestion(question: Question) {
        questionLabel.text = question.text
        answerOne.text = question.answerOptions[0]
        answerTwo.text = question.answerOptions[1]
        answerThree.text = question.answerOptions[2]
        answerFour.text = question.answerOptions[3]
        questionNumberLabel.text = "Вопрос: \(millionaire.numberOfQuestion)"
        questionMoneyLabel.text = "\(money[millionaire.numberOfQuestion - 1]) ₽"
        if millionaire.isHintTapped[0] == true {
            fiftyCloseView.alpha = 1
            fiftyButton.isUserInteractionEnabled = false
        }
        if millionaire.isHintTapped[1] == true {
            hallCloseView.alpha = 1
            hallButton.isUserInteractionEnabled = false
        }
        if millionaire.isHintTapped[2] == true {
            friendCloseView.alpha = 1
            friendButton.isUserInteractionEnabled = false
        }
            
    }
    
    //MARK: - View - Success
    
    func success(successType: GameSuccessType, numberOfQuestion: Int, numberOfAnswer: Int) {
        
        switch successType {
        case .answer:
            //проигрываем музыку правильного ответа
            musicGame.stop()
            musicGame.play(sound: "correctAnswer")
            
            //изменение цвета кнопки
            setButtonBackground(answerNumber: numberOfAnswer, colour: .green)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.performSegue(withIdentifier: "goToResult", sender: self)
            })
        case .hintFifty:
            fiftyCloseView.alpha = 1.0
            fiftyCloseView.isUserInteractionEnabled = false
            fiftyButton.isUserInteractionEnabled = false
        case .hallAssistance:
            return
        case .callToFriends:
            return
        }
        
        
    }
    
    //MARK: - View - Failure
    
    func failure(numberOfQuestion: Int, numberOfAnswer: Int) {
        
        //проигрываем музыку в случае неудачи
        musicGame.stop()
        musicGame.play(sound: "wrongAnswer")
            
        
        setButtonBackground(answerNumber: numberOfAnswer, colour: .red)
        
        if let index = millionaire.question.answerOptions.firstIndex(where: {$0 == millionaire.question.answer}) {
            setButtonBackground(answerNumber: index + 1, colour: .green)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.performSegue(withIdentifier: "goToResult", sender: self)
        })
        
    }
    
    //MARK: - Extension Methods
    
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
            view.isHint = millionaire.isHintTapped
            view.money = money[millionaire.numberOfQuestion - 1]
        }
    }
    
}
