//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by 丸山航輝 on 2023/09/02.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    
    // 問題
    var questions: [[String: Any]] = [
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQestion()
        // Display question after loading
    }
    
    
    // 問題を表示する関数
    func showQestion(){
        if currentQuestionNum >= questions.count {
            questionLabel.text = "問題がありません"
            return
        }
        
        let question = questions[currentQuestionNum]
        
        if let que = question["question"] as? String {
            questionLabel.text = que
        }
    }
    
    func checkAnswer(yourAnswer: Bool){
        // 関数を終了してアラートを出すための関数
        if currentQuestionNum >= questions.count {
            showAlert(message: "問題がありません")
            return
        }
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool{
            if yourAnswer == ans {
                currentQuestionNum += 1
                showAlert(message: "正解!")
            } else {
                showAlert(message: "不正解!")
            }
            
        } else {       // 答えがないとき
            print("答えが入っていません")
            return
        }
  
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        
        showQestion()
    }
    
    // アラートを表示
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tappedNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
    
    // 問題作成画面移動するボタン
    @IBAction func createQuestionButtonTapped(_ sender: Any) {
        let createQuestionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateQuestionViewController") as! CreateQuestionViewController
        createQuestionVC.questions = self.questions
        createQuestionVC.delegate = self // ViewControllerをデリゲートとして設定
        present(createQuestionVC, animated: true, completion: nil)
    }

}

extension ViewController: CreateQuestionDelegate {
    func didUpdateQuestions(updatedQuestions: [[String : Any]]) {
        self.questions = updatedQuestions
        currentQuestionNum = 0
        showQestion()
    }
}
