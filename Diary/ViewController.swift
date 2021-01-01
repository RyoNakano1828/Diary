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
    
    let dateView = FSCalendar(frame: CGRect(x: 0, y: 0, width: width, height: 400))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //カレンダーの設定
        self.dateView.dataSource = self
        self.dateView.delegate = self
        self.dateView.today = nil
        view.addSubview(dateView)
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
    
    //土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
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
    
}

