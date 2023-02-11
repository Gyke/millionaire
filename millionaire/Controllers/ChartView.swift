//
//  ChartView.swift
//  millionaire
//
//  Created by Sergey on 10.02.2023.
//

import UIKit

class ChartView: UIView {
    
    @IBOutlet weak var answerOne: UIView!
    @IBOutlet weak var answerTwo: UIView!
    @IBOutlet weak var answerThree: UIView!
    @IBOutlet weak var answerFour: UIView!
    @IBOutlet var contentView: UIView!
    
    var data: [AnswerData]?
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit () {
        
        let viewFromXib = Bundle.main.loadNibNamed("ChartView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        viewFromXib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(viewFromXib)
   
        
    }
    
   
       
    
    func moveBar(chartData: [AnswerData]) {
        
        for answer in chartData {
            switch answer.answerNumber {
            case 0:
                let newSize: CGFloat = 100 - CGFloat(answer.percentage)
                answerOne.frame.size.height = newSize
                let constr = answerOne.heightAnchor.constraint(equalToConstant: newSize)
                NSLayoutConstraint.activate([constr])
                contentView.layoutIfNeeded()
            case 1:
                answerTwo.frame.size.height = 100 - CGFloat(answer.percentage)
                let constr = answerTwo.heightAnchor.constraint(equalToConstant: 100 - CGFloat(answer.percentage))
                NSLayoutConstraint.activate([constr])
                contentView.layoutIfNeeded()
            case 2:
                answerThree.frame.size.height = 100 - CGFloat(answer.percentage)
                let constr = answerThree.heightAnchor.constraint(equalToConstant: 100 - CGFloat(answer.percentage))
                NSLayoutConstraint.activate([constr])
                contentView.layoutIfNeeded()
            case 3:
                answerFour.frame.size.height = 100 - CGFloat(answer.percentage)
                let constr = answerFour.heightAnchor.constraint(equalToConstant: 100 - CGFloat(answer.percentage))
                NSLayoutConstraint.activate([constr])
                contentView.layoutIfNeeded()
            default:
                return
            }
            
            
        }
    }
    
  
    
}
