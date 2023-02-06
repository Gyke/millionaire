//
//  Question.swift
//  millionaire
//
//  Created by Batman 👀 on 06.02.2023.
//

import Foundation

struct Question {
    let text : String
    let answerOptions: [String]
    let answer: String
    
    init( a: String, b: [String], correctAnswer: String ){
        text = a
        answerOptions = b
        answer = correctAnswer
    }
}
