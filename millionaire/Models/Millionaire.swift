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
    init(view: MillionaireViewProtocol, numberOfQuestion: Int, isHintTapped: [Bool])
}

protocol MillionaireViewProtocol: AnyObject {
    func setQuestion(question: Question)
    func success(successType: GameSuccessType, numberOfQuestion: Int, numberOfAnswer: Int)
    func failure(numberOfQuestion: Int, numberOfAnswer: Int)
}

class Millionaire: MillionaireProtocol {
    
    weak var view: MillionaireViewProtocol!
    var quiz = QuizMillionaire()
    var numberOfQuestion: Int
    var question: Question
    var answerResult: Bool
    var isHintTapped: [Bool]
    required init(view: MillionaireViewProtocol, numberOfQuestion: Int, isHintTapped: [Bool]) {
        self.view = view
        self.numberOfQuestion = numberOfQuestion
        self.question = quiz.quiz[numberOfQuestion - 1]
        self.answerResult = false
        self.isHintTapped = isHintTapped
    }
    
    func answerTapped(answer: String, numberOfAnswer: Int) {
        //Запускаем музыку
        
        //даем паузу в пять секунд
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            if answer == self.question.answer {
                self.answerResult = true
                self.view.success(successType: .answer, numberOfQuestion: self.numberOfQuestion, numberOfAnswer: numberOfAnswer)
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
            let trueIndex = question.answerOptions.firstIndex(where: {$0 == question.answer})
            var hint: [Int] = [0, 0, 0, 0]
            for i in 0...3 {
                switch i {
                case 0:
                    if i == trueIndex { hint[i] = 50 } else { hint[i] = Bool.random() ? 50 : 0 }
                case 1:
                    if i == trueIndex { hint[i] = 50 } else { hint[i] = Bool.random() ? 50 : 0 }
                case 2:
                    
                    if i == trueIndex {
                        hint[i] = 50
                        let res = hint.filter{ $0 > 0 }
                        if res.count == 3 {
                            hint[Int.random(in: 0...1)] = 0
                        }
                    } else {
                        let res = hint.filter{ $0 > 0 }
                        if res.count == 0 {
                            hint[i]  = 50
                        } else {
                            hint[i] = Bool.random() ? 50 : 0
                        }
                    }
                case 3:
                    let res = hint.filter{ $0 > 0 }
                    if i == trueIndex { hint[i] = 50 } else { if res.count == 1 { hint[i] = 50 } else if res.count == 2 { hint[i] = 0 } }
                default:
                    break
                }
            }
            return hint
        case .hallAssistance:
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


