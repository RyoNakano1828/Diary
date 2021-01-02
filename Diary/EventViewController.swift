//
//  EventViewController.swift
//  Diary
//
//  Created by NeppsStaff on 2021/01/02.
//

import UIKit

class EventViewController: UIViewController {

    let eventTextView = UITextView(frame: CGRect(x: (width - 300) / 2, y: 100, width: 300, height: 400))
    let backBtn = UIButton(frame: CGRect(x: (width-200)/2, y: height-100, width: 200, height: 30))


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //スケジュール内容入力テキスト
        eventTextView.text = ""
        eventTextView.font = UIFont.systemFont(ofSize: 18)
        eventTextView.backgroundColor = UIColor(displayP3Red: 30/255, green: 144/255, blue: 255/255, alpha: 0.1)
        eventTextView.layer.borderColor = UIColor(displayP3Red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor
        eventTextView.layer.cornerRadius = 10.0
        view.addSubview(eventTextView)
        
        //戻るボタン設置
        backBtn.setTitle("戻る", for: UIControl.State())
        backBtn.setTitleColor(UIColor(displayP3Red: 30/255, green: 144/255, blue: 255/255, alpha: 1), for: UIControl.State())
        backBtn.layer.cornerRadius = 10.0
        backBtn.backgroundColor = .white
        backBtn.layer.borderColor = UIColor(displayP3Red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor
        backBtn.layer.borderWidth = 1.0
        backBtn.addTarget(self, action: #selector(onbackClick), for: .touchUpInside)
        view.addSubview(backBtn)
        
        //キーボードを閉じるためのボタンを追加する
        //ツールバーを生成
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        //閉じるボタンを右に設置するためのスペース
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        //閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.commitButtonTapped))
        toolBar.items = [spacer, commitButton]
        eventTextView.inputAccessoryView = toolBar
    }
    
    //画面遷移(main画面へ)
    @objc func onbackClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
