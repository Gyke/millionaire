//
//  ChartPrepare.swift
//  millionaire
//
//  Created by Sergey on 10.02.2023.
//

import Foundation

protocol ChartPrepareProtocol: AnyObject {
    func generatePercentForAnswer(trueAnswer: Int) -> [AnswerData]
    
}

class ChartPrepare: ChartPrepareProtocol, ObservableObject  {
    
    //    var trueAnswerNumber: Int = 1
    var truePercent: Int = 60
    
    public func generatePercentForAnswer(trueAnswer: Int) -> [AnswerData] {
        var data: [AnswerData] = []
        data.append(AnswerData(answerNumber: trueAnswer, percentage: truePercent))
        var tempPercent: Int = 0
        
        for  index in 0...3  {
            if index != trueAnswer {
                tempPercent = 100 - truePercent - tempPercent
                tempPercent = Int.random(in: 0...tempPercent)
                data.append(AnswerData(answerNumber: index, percentage: tempPercent))
            }
        }
        return data
    }
    
}
