//
//  CreateQuestionViewController.swift
//  MarubatsuApp
//
//  Created by 丸山航輝 on 2023/09/07.
//


import UIKit

protocol CreateQuestionDelegate {
    func didUpdateQuestions(updatedQuestions: [[String : Any]])
}

class CreateQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerSegmentedControl: UISegmentedControl!
    
    // 問題を保存するための配列
    var questions: [[String: Any]] = []
    
    var delegate: CreateQuestionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 指示文を設定
        questionTextField.placeholder = "問題文を入力してください"
    }
    
    // 問題を保存するボタンのアクション
    @IBAction func saveQuestionButtonTapped(_ sender: Any) {
        guard let questionText = questionTextField.text, !questionText.isEmpty else {
            showAlert(message: "問題を入力してください")
            return
        }
        
        let answer = answerSegmentedControl.selectedSegmentIndex == 1 // 0がTrue、1がFalseと仮定
        let newQuestion = [
            "question": questionText,
            "answer": answer
        ] as [String : Any]
        
        questions.append(newQuestion)
        questionTextField.text = ""
        showAlert(message: "問題を保存しました")
        delegate?.didUpdateQuestions(updatedQuestions: questions) // 保存した問題をViewControllerに渡す
    }
    // すべての問題を削除するボタンのアクション
    @IBAction func deleteAllQuestionsButtonTapped(_ sender: Any) {
        questions.removeAll()
        showAlert(message: "すべての問題を削除しました")
    }
    
    // TOPに戻るボタンのアクション
    @IBAction func backButtonTapped(_ sender: Any) {
        delegate?.didUpdateQuestions(updatedQuestions: questions) // 保存した問題をViewControllerに渡す
        dismiss(animated: true, completion: nil)
    }
    
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
