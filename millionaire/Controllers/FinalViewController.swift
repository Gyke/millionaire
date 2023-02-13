//
//  FinalViewController.swift
//  millionaire
//
//  Created by Михаил Позялов on 09.02.2023.
//

import UIKit

class FinalViewController: UIViewController {
    
    
    
    var win: Int?
    var result: String?
  
    @IBOutlet weak var winAmount: UILabel!
    @IBOutlet weak var resultGameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var registerButton:UIButton!
    
    var usersStat: [String] = []
    //Экземпляр плеера
    let musicEnd = AudioPlayer()
    var finalController: FinalControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        finalController.setData()

    }
    
    //Для постоянного воспроизведения
    func playMusic(loop: Bool) {
        musicEnd.play(sound: "endOfGame")
            if loop {
                musicEnd.player?.numberOfLoops = -1
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        playMusic(loop: true)
    }
    
    @IBAction func playAgeinButtonPressed(_ sender: UIButton) {
        
        musicEnd.stop()
        rightToMakeMistake = false
        self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Сохранить", message: "Введите имя пользователя", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.textContentType = .name
            textField.placeholder = "Имя"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            let userName = alert.textFields![0] as UITextField
            self.finalController.saveTapped(userName: userName.text ?? "NoName")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { alertAction in
            return
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    @IBAction func backToMainButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToMain", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        musicEnd.stop()
        if segue.identifier == "goToGame" {
            let view = segue.destination as! GameViewController
            let millionaire = Millionaire(view: view, prepareChart: ChartPrepare(), numberOfQuestion: 1, isHintTapped: [false, false, false] )
            view.millionaire = millionaire
        }
    }
}

extension FinalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        finalController.userScoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? ResultTableViewCell {
            cell.userNameLabel.text = finalController.userScoreData[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension FinalViewController: FinalControllerViewProtocol {
    
    func success(successType: FinalSuccessType) {
        switch successType {
        case .loadDataOk:
            winAmount.text = "Вы заработали: \(String(finalController.moneyWin ?? 0))  ₽"
            if let result = finalController.result {
                resultGameLabel.text = result ? "ПОБЕДА" : "ПРИГРЫШ"
            }
            tableView.reloadData()
        case .losOk:
            winAmount.text = String(finalController.moneyWin ?? 0) + " ₽"
            if let result = finalController.result {
                resultGameLabel.text = result ? "ПОБЕДА" : "ПРИГРЫШ"
            }
            registerButton.isHidden = false
            tableView.reloadData()
        case .winOk:
            winAmount.text = String(finalController.moneyWin ?? 0) + " ₽"
            if let result = finalController.result {
                resultGameLabel.text = result ? "ПОБЕДА" : "ПРИГРЫШ"
            }
            registerButton.isHidden = false
            tableView.reloadData()
        case .saveOk:
            tableView.reloadData()
        }
    }
 
    
    
}
