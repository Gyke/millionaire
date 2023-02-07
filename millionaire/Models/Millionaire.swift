//
//  Millionaire.swift
//  millionaire
//
//  Created by Константин Стольников on 2023/02/05.
//

import Foundation

protocol MillionaireProtocol: AnyObject {
    func answerTapped(answer: String)
    func hintTapped()
    func setQuestion()
    var question: Question {get set}
    init(view: MillionaireViewProtocol, numberOfQuestion: Int)
}

protocol MillionaireViewProtocol: AnyObject {
    func setQuestion(question: Question)
    func success()
    func failure()
}

class Millionaire: MillionaireProtocol {
    
    weak var view: MillionaireViewProtocol!
    var quiz = QuizMillionaire()
    var numberOfQuestion: Int!
    var question: Question
    required init(view: MillionaireViewProtocol, numberOfQuestion: Int) {
        self.view = view
        self.numberOfQuestion = numberOfQuestion
        self.question = quiz.quiz[numberOfQuestion]
    }
    
    func answerTapped(answer: String) {
        print("\(answer)")
    }
    
    func hintTapped() {
        
    }
    
    public func setQuestion() {
        self.view.setQuestion(question: quiz.quiz[numberOfQuestion])
    }
    
}
