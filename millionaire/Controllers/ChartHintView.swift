//
//  ChartHintView.swift
//  millionaire
//
//  Created by Sergey on 09.02.2023.
//

import UIKit
import Charts

class ChartHintView: UIView {

    var trueAnswerNumber: Int = 1
    var truePercent: Int = 70
    
    
//    func makeChart(trueAnswer: Int)  {
//        let answerData = generatePercentForAnswer(trueAnswer: trueAnswerNumber)
//        var body: some ChartHintView {
//            Chart(answerData) {
//                BarMark(
//                    x: .value("Question", $0.answerNumber),
//                    y: .value("Percent", $0.percentage)
//                )
//            }
//        }
//    }
    
    
    

    func generatePercentForAnswer(trueAnswer: Int) -> [AnswerData] {
        var data: [AnswerData] = [AnswerData(answerNumber: 0, percentage: 0),
                                  AnswerData(answerNumber: 0, percentage: 0),
                                  AnswerData(answerNumber: 0, percentage: 0),
                                  AnswerData(answerNumber: 0, percentage: 0)]
        for i in 0...3 {
            if i == trueAnswer - 1 {
                data[i] = AnswerData(answerNumber: i, percentage: truePercent)
            } else {
                var percentSum: Int = 0
                for answer in data {
                    percentSum += answer.percentage
                }
                percentSum -= truePercent
                data[i] = AnswerData(answerNumber: i, percentage: Int.random(in: 0...percentSum))
            }
        }
        
        
        return data
    }

}
