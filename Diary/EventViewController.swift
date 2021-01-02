//
//  EventViewController.swift
//  Diary
//
//  Created by NeppsStaff on 2021/01/02.
//

import UIKit
import RealmSwift

class EventViewController: UIViewController {

    let eventTextView = UITextView(frame: CGRect(x: (width - 300) / 2, y: 100, width: 300, height: 400))
    let dateLabel = UILabel(frame: CGRect(x: (width - 300) / 2, y: 70, width: 300, height: 20))
    let backBtn = UIButton(frame: CGRect(x: (width-200)/2, y: height-100, width: 200, height: 30))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //日付表示設定
        dateLabel.backgroundColor = .white
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        let selectedDate = UserDefaults.standard.object(forKey: "selectedDate") as! String
        dateLabel.text = selectedDate
        view.addSubview(dateLabel)
        
        //スケジュール内容入力テキスト
        eventTextView.text = ""
        eventTextView.font = UIFont.systemFont(ofSize: 18)
        eventTextView.backgroundColor = UIColor(displayP3Red: 30/255, green: 144/255, blue: 255/255, alpha: 0.1)
        eventTextView.layer.borderColor = UIColor(displayP3Red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor
        eventTextView.layer.cornerRadius = 10.0
        view.addSubview(eventTextView)
        
        //カレンダーに保存ボタン
        let saveButton = UIButton(frame: CGRect(x: (width - 200) / 2, y: height - 160, width: 200, height: 50))
        saveButton.setTitle("カレンダーに保存", for: UIControl.State())
        saveButton.setTitleColor(.white, for: UIControl.State())
        saveButton.backgroundColor = UIColor(displayP3Red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
        saveButton.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        view.addSubview(saveButton)
        
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
        
        getSchedule(date: dateLabel.text!)
    }
    
    //スケジュール取得
    func getSchedule(date: String) {
        let realm = try! Realm()
        var result = realm.objects(Event.self)
        result = result.filter("date = '\(date)'")
        if let event = result.last {
            print(event.event)
            eventTextView.text = event.event
        }else {
            return
        }
    }

    
    //画面遷移(main画面へ)
    @objc func onbackClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }
    
    //DB書き込み処理
    @objc func saveEvent() {
        print("データ書き込み開始")
        let realm = try! Realm()
        try! realm.write {
            //日付表示の内容とスケジュール入力内容が書き込まれる
            let events = [Event(value: ["date": dateLabel.text, "event": eventTextView.text])]
            realm.add(events)
            print(events)
            print("データ書き込み中")
        }
        print("データ書き込み完了")
        
        //前のページに戻る
        dismiss(animated: true, completion: nil)
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
