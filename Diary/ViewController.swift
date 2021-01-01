//
//  ViewController.swift
//  Diary
//
//  Created by NeppsStaff on 2021/01/01.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    let dateView = FSCalendar(frame: CGRect(x: 0, y: 30, width: width, height: 400))
    let scheduleView = UIView(frame: CGRect(x: 0, y: 430, width: width, height: height))
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 80, width: 180, height: 40))
    let contentLabel = UILabel(frame: CGRect(x: 5, y: 120, width: 400, height: 100))
    let selectedDateLabel = UILabel(frame: CGRect(x: 5, y: 0, width: 300, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //カレンダーの設定
        self.dateView.dataSource = self
        self.dateView.delegate = self
        self.dateView.today = nil
        view.addSubview(dateView)
        
        //下のとこ青くする
        scheduleView.backgroundColor = UIColor.blue
        view.addSubview(scheduleView)
        
        //タイトルラベル
        titleLabel.text = "主なスケジュール"
        titleLabel.backgroundColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20.0)
        scheduleView.addSubview(titleLabel)
        
        //スケジュール内容表示設定
        contentLabel.text = "スケジュールはありません"
        contentLabel.textColor = .white
        contentLabel.font = UIFont.systemFont(ofSize: 18.0)
        scheduleView.addSubview(contentLabel)
        
        //日付表示設定
        selectedDateLabel.text = "07/04"
        selectedDateLabel.textColor = .white
        selectedDateLabel.font = UIFont.systemFont(ofSize: 40.0)
        scheduleView.addSubview(selectedDateLabel)
    }
    
    //祝日判定メソッド
    func judgeHoliday(_ date : Date) -> Bool {
        let tmpCalenddar = Calendar(identifier: .gregorian)
        //祝日判定を行う年月日を取得
        let year = tmpCalenddar.component(.year, from: date)
        let month = tmpCalenddar.component(.month, from: date)
        let day = tmpCalenddar.component(.day, from: date)
        
        let holiday = CalculateCalendarLogic()
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    //曜日判定
    func getWeekIdx(_ date: Date) -> Int {
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    //誕生日判定
    func getBirthday(_ date: Date) -> String {
        let tmpCalendar = Calendar(identifier: .gregorian)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        
        let myBirthday = "\(m)/\(d)"
        return myBirthday
    }
    
    //土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //誕生日判定は先に書かないと休日でreturnしちゃう
        if self.getBirthday(date) == "11/18" {
            return UIColor.green
        }
        //祝日判定する
        if self.judgeHoliday(date) {
            return UIColor.red
        }
        //土日の判定
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {
            return UIColor.red
        }
        else if weekday == 7 {
            return UIColor.blue
        }
        
        return nil
    }
    
    //スケジュール表示処理（クリックした日付を取得）
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        let y = String(format: "%04d", year)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        
        selectedDateLabel.text = "\(y)/\(m)/\(d)"
    }
    
}

