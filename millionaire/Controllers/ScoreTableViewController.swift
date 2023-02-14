//
//  ScoreTableViewController.swift
//  millionaire
//
//  Created by Sergey on 08.02.2023.
//

import UIKit

class ScoreTableViewController: UIViewController {
    
    //MARK: - Variables
    
    var questionNumber: Int?
    var answerResult: Bool?
    var isHint: [Bool]?
    let recognizer = UITapGestureRecognizer()
    var money: Int?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var oneQuestionButton: UIButton!
    @IBOutlet weak var twoQuestionButton: UIButton!
    @IBOutlet weak var threeQuestionButton: UIButton!
    @IBOutlet weak var fourQuestionButton: UIButton!
    @IBOutlet weak var fiveQuestionButton: UIButton!
    @IBOutlet weak var sixQuestionButton: UIButton!
    @IBOutlet weak var sevenQuestionButton: UIButton!
    @IBOutlet weak var eightQuestionButton: UIButton!
    @IBOutlet weak var nineQuestionButton: UIButton!
    @IBOutlet weak var tenQuestionButton: UIButton!
    @IBOutlet weak var elevenQuestionButton: UIButton!
    @IBOutlet weak var twelveQuestionButton: UIButton!
    @IBOutlet weak var thirteenQuestionButton: UIButton!
    @IBOutlet weak var fourteenQuestionButton: UIButton!
    @IBOutlet weak var fifteenQuestionButton: UIButton!
    var buttonsArray: [UIButton] = []
    
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonsArray = [
            oneQuestionButton,
            twoQuestionButton,
            threeQuestionButton,
            fourQuestionButton,
            fiveQuestionButton,
            sixQuestionButton,
            sevenQuestionButton,
            eightQuestionButton,
            nineQuestionButton,
            tenQuestionButton,
            elevenQuestionButton,
            twelveQuestionButton,
            thirteenQuestionButton,
            fourteenQuestionButton,
            fifteenQuestionButton
        ]
        buttonsArray.forEach({ $0.isUserInteractionEnabled = false })
        
        recognizer.addTarget(self, action: #selector(handleTapGesture(_:)))
        view.addGestureRecognizer(recognizer)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: - Methods
    
    func lightAnswer(result: Bool, questionNumber: Int) {
        
        buttonsArray[questionNumber - 1].setBackgroundImage(result == true ? ButtonColor.green.image : ButtonColor.red.image , for: .normal)
        
        //Изменение изображения кнопк, по мере привильх ответов от пользователя.
        if result == true {
            for i in 0..<questionNumber {
                buttonsArray[i].setBackgroundImage(UIImage(named: "Rectangle green"), for: .normal)
            }
        }
        
        
        
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard let result = answerResult else { return }
        guard let questionNumber = questionNumber else { return }
        if questionNumber < 15 {
            if result {
                self.performSegue(withIdentifier: "returnToGame", sender: self)
            } else {
                self.performSegue(withIdentifier: "goToFinish", sender: self)
            }
            
        } else {
            self.performSegue(withIdentifier: "goToFinish", sender: self)
        }
        
    }
    
    func goToNextScreeWithDelay(result: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
            
            if result {
                self.performSegue(withIdentifier: "returnToGame", sender: self)
            } else {
                self.performSegue(withIdentifier: "goToFinish", sender: self)
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let result = answerResult else { return }
        guard let number = questionNumber else { return }
        lightAnswer(result: result, questionNumber: number)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "returnToGame" {
            let view = segue.destination as! GameViewController
            guard let nextNumber = questionNumber else { return }
            guard let isHint = isHint else { return }
            let chartPrepare = ChartPrepare()
            let millionaire = Millionaire(view: view, prepareChart: chartPrepare, numberOfQuestion: nextNumber + 1, isHintTapped: isHint )
            view.millionaire = millionaire
        } else if segue.identifier == "goToFinish" {
            let view = segue.destination as! FinalViewController
            guard let result = answerResult else { return }
            let finalController = FinalControllerClass(view: view, result: result, moneyWin: money ?? 0)
            view.finalController = finalController
        }
    }
    
}
