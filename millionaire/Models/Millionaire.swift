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
    
}

protocol MillionaireProtocol: AnyObject {
    func answerTapped(answer: String, numberOfAnswer: Int)
    func hintTapped()
    func setQuestion()
    func timeIsOver()
    var question: Question {get set}
    var answerResult: Bool {get set}
    var numberOfQuestion: Int {get set}
    init(view: MillionaireViewProtocol, numberOfQuestion: Int)
}

protocol MillionaireViewProtocol: AnyObject {
    func setQuestion(question: Question)
    func success(numberOfQuestion: Int, numberOfAnswer: Int)
    func failure(numberOfQuestion: Int, numberOfAnswer: Int)
}

class Millionaire: MillionaireProtocol {
    
    weak var view: MillionaireViewProtocol!
    var quiz = QuizMillionaire()
    var numberOfQuestion: Int
    var question: Question
    var answerResult: Bool
    required init(view: MillionaireViewProtocol, numberOfQuestion: Int) {
        self.view = view
        self.numberOfQuestion = numberOfQuestion
        self.question = quiz.quiz[numberOfQuestion - 1]
        self.answerResult = false
    }
    
    func answerTapped(answer: String, numberOfAnswer: Int) {
        //Запускаем музыку
        
        //даем паузу в пять секунд
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            if answer == self.question.answer {
                self.answerResult = true
                self.view.success(numberOfQuestion: self.numberOfQuestion, numberOfAnswer: numberOfAnswer)
            } else {
                self.view.failure(numberOfQuestion: self.numberOfQuestion, numberOfAnswer: numberOfAnswer)
            }
        })
        
    }
    
    func hintTapped() {
        
    }
    
   
    
    public func setQuestion() {
        self.view.setQuestion(question: quiz.quiz[numberOfQuestion - 1])
    }
    
    func timeIsOver() {
        
    }
    
}
