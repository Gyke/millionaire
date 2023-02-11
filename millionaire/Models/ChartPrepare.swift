//
//  ChartPrepare.swift
//  millionaire
//
//  Created by Sergey on 10.02.2023.
//

import Foundation

protocol ChartPrepareProtocol: AnyObject {
    func generatePercentForAnswer(trueAnswer: Int) -> [AnswerData]
    var data: [AnswerData] {get set}
}

class ChartPrepare: ChartPrepareProtocol, ObservableObject  {

//    var trueAnswerNumber: Int = 1
    var truePercent: Int = 60
    var data: [AnswerData] = [AnswerData(answerNumber: 0, percentage: 0),
                              AnswerData(answerNumber: 0, percentage: 0),
                              AnswerData(answerNumber: 0, percentage: 0),
                              AnswerData(answerNumber: 0, percentage: 0)] { willSet { objectWillChange.send() }}
   public func generatePercentForAnswer(trueAnswer: Int) -> [AnswerData] {
        
        for i in 0...3 {
            if i == trueAnswer - 1 {
                data[i] = AnswerData(answerNumber: i, percentage: truePercent)
            } else {
                var percentSum: Int = 0
                for answer in data {
                    percentSum += answer.percentage
                }
                percentSum += 100
                percentSum  -= truePercent
                data[i] = AnswerData(answerNumber: i, percentage: Int.random(in: 0...percentSum))
            }
        }

       return data
    }

}
