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
    
    // 問題の定義。広義の拡張
    var questions: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQestion()
    }
    
    
    func showQestion(){
        if currentQuestionNum >= questions.count {
            questionLabel.text = "問題を作成してください。"
            return
        }
        
        let question = questions[currentQuestionNum]
        
        if let que = question["question"] as? String {
            questionLabel.text = que
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    func checkAnswer(yourAnswer: Bool){
        if currentQuestionNum >= questions.count {
            showAlert(message: "問題を作成してください。")
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
            
        } else {
            print("答えがありません")
            return
        }
  
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        
        showQestion()
    }
    
    
    @IBAction func tappedNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
    
    //画面遷移
    @IBAction func createQuestionButtonTapped(_ sender: Any) {
        let createQuestionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateQuestionViewController") as! CreateQuestionViewController
        createQuestionVC.questions = self.questions
        createQuestionVC.delegate = self
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
