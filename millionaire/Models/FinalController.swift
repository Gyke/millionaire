//
//  FinalController.swift
//  millionaire
//
//  Created by Sergey on 12.02.2023.
//

import Foundation

enum FinalSuccessType {
    case loadDataOk
    case losOk
    case winOk
    case saveOk
}

protocol FinalControllerProtocol: AnyObject {
    func saveTapped(userName: String)
    func getData()
    func setData()
    var moneyWin: Int? {get set}
    var result: Bool? {get set}
    var userScoreData: [String] {get set}
    init(view: FinalControllerViewProtocol, result: Bool, moneyWin: Int)
}

protocol FinalControllerViewProtocol: AnyObject {
    func success(successType: FinalSuccessType)
}

class FinalControllerClass: FinalControllerProtocol {
    weak var view: FinalControllerViewProtocol?
    var moneyWin: Int?
    var result: Bool?
    var defaults = UserDefaults.standard
    var userScoreData: [String] = []
    var formatter = DateFormatter()
    required init(view: FinalControllerViewProtocol, result: Bool, moneyWin: Int) {
        self.view = view
        self.result = result
        self.moneyWin = moneyWin
        getData()
    }
    
    func saveTapped(userName: String) {
        if let moneyWin = moneyWin {
            userScoreData = defaults.object(forKey: "winsList") as? [String] ?? [String]()
            formatter.dateFormat = "MM-dd-yyyy HH:mm"
            let saveDate = formatter.string(from: Date())
            userScoreData.append("\(userName)   \(saveDate)   \(moneyWin)")
            defaults.set(userScoreData, forKey: "winsList")
            view?.success(successType: .saveOk)
        }
    }
    
    func getData() {
        userScoreData = defaults.object(forKey: "winsList") as? [String] ?? [String]()
    }
    
    func setData() {
        getData()
        if moneyWin == 0 {
            view?.success(successType: .loadDataOk)
        } else {
            if result == true {
                view?.success(successType: .winOk)
            } else {
                view?.success(successType: .losOk)
            }
        }
        
    }
    
    
    
    
}
