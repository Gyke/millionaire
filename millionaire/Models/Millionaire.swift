//
//  Millionaire.swift
//  millionaire
//
//  Created by Константин Стольников on 2023/02/05.
//

import Foundation

enum GameSuccessType {
    case answer
    case hintFifty
    case hallAssistance
    case callToFriends
    
}

protocol MillionaireProtocol: AnyObject {
    func answerTapped(answer: String, numberOfAnswer: Int)
    func hintTapped(hintType: GameSuccessType) -> [Int]
    func setQuestion()
    func timeIsOver()
    var question: Question {get set}
    var answerResult: Bool {get set}
    var numberOfQuestion: Int {get set}
    var isHintTapped: [Bool] {get set}
    init(view: MillionaireViewProtocol, prepareChart: ChartPrepareProtocol, numberOfQuestion: Int, isHintTapped: [Bool])
}

protocol MillionaireViewProtocol: AnyObject {
    func setQuestion(question: Question)
    func success(successType: GameSuccessType, numberOfQuestion: Int, numberOfAnswer: Int, answerPercent: [AnswerData]?)
    func failure(numberOfQuestion: Int, numberOfAnswer: Int)
}

class Millionaire: MillionaireProtocol {
    
    weak var view: MillionaireViewProtocol!
    var chartView = ChartView()
    var prepareChart: ChartPrepareProtocol!
    var quiz = QuizMillionaire()
    var numberOfQuestion: Int
    var question: Question
    var answerResult: Bool
    var isHintTapped: [Bool]
    required init(view: MillionaireViewProtocol, prepareChart: ChartPrepareProtocol, numberOfQuestion: Int, isHintTapped: [Bool]) {
        self.view = view
        self.numberOfQuestion = numberOfQuestion
        self.question = quiz.quiz[numberOfQuestion - 1]
        self.answerResult = false
        self.isHintTapped = isHintTapped
        self.prepareChart = prepareChart
    }
    
    func answerTapped(answer: String, numberOfAnswer: Int) {
        //Запускаем музыку
        
        //даем паузу в пять секунд
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            if answer == self.question.answer {
                self.answerResult = true
                self.view.success(successType: .answer, numberOfQuestion: self.numberOfQuestion, numberOfAnswer: numberOfAnswer, answerPercent: nil)
            } else {
                self.view.failure(numberOfQuestion: self.numberOfQuestion, numberOfAnswer: numberOfAnswer)
            }
        })
        
    }
    
    func hintTapped(hintType: GameSuccessType) -> [Int] {
        switch hintType {
        case .answer:
            return []
        case .hintFifty:
            isHintTapped[0] = true
            var hint: [Int] = [0, 0, 0, 0]
            if let trueIndex = question.answerOptions.firstIndex(where: {$0 == question.answer}) {
                
                let index: Int = Int(trueIndex )
                hint[index] = 50
                var temp: [Int] = []
                var i = 0
                for hi in hint {
                    if hi != 50 {
                        temp.append(i)
                        i += 1
                    } else {
                        i += 1
                    }
                    
                }
                let hintIndex = Int.random(in: 1...3)
               hint[temp[hintIndex - 1]] = 50
                
                
            }
            return hint
 
            
        case .hallAssistance:
            isHintTapped[1] = true
            let trueIndex = question.answerOptions.firstIndex(where: {$0 == question.answer})
            let trueAnswer = prepareChart.generatePercentForAnswer(trueAnswer: trueIndex ?? 1)
            view.success(successType: .hallAssistance, numberOfQuestion: numberOfQuestion, numberOfAnswer: trueIndex ?? 1, answerPercent: trueAnswer)
            return []
        case .callToFriends:
            return []
        }
    }
    
    
    
    public func setQuestion() {
        self.view.setQuestion(question: quiz.quiz[numberOfQuestion - 1])
    }
    
    func timeIsOver() {
        
    }
    
}


