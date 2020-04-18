//
//  Date.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

extension Date {

    func printDate(format: String = "d MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }

    var todayDate: String {

        let today = Date().printDate(format: "d.MM.yyyy")
        let date = self.printDate(format: "d.MM.yyyy")

        if today == date {
            return self.printDate(format: "HH:mm")
        } else {
            return date
        }
    }



    //календарь

    init(day: Int?, month: Int?, year: Int?) {

        guard let day = day, let month = month, let year = year else {
            self = Date()
            return
        }

        if month < 13, month > 0, day > 0, year > 0, let date = "\(day) \(month) \(year)".getDatwToString("dd MM yyyy") {
            self = Date(timeInterval: 0, since: date)
            return
            //            self.init(timeInterval: 0, since: date)
        }

        self = Date()
    }

    init(day: String, month: String, year: String) {
        self.init(day: Int(day), month: Int(month), year: Int(year))
    }



    //количество дней в этом месяце

    var countDayInMonth: Int {

        let dateComponents = DateComponents(year: self.year, month: self.monthNumber)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!

        return range.count

    }


    //КОЛИЧЕСТВО ПОЛНЫХ НЕДЕЛЬ

    var weeksInMonth: Int {

        let month = self.monthNumber
        let year = self.year


        let dateString = String(format: "%4d/%d/01", year, month)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.date(from: dateString), let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian){
            calendar.firstWeekday = 2 // Monday
            let weekRange = calendar.range(of: .weekOfMonth, in: .month, for: date)
            let weeksCount = weekRange.length
            return weeksCount
        } else {
            return 5
        }
    }



    var year: Int {
        let str = self.printDate(format: "yyyy")
        return Int(str)!
    }

    var day: Int {
        let str = self.printDate(format: "d")
        return Int(str)!
    }

    var monthString: String{
        switch monthNumber {
        case 1:
            return "Январь"
        case 2:
            return "Февраль"
        case 3:
            return "Март"
        case 4:
            return "Апрель"
        case 5:
            return "Май"
        case 6:
            return "Июнь"
        case 7:
            return "Июль"
        case 8:
            return "Август"
        case 9:
            return "Сентябрь"
        case 10:
            return "Октябрь"
        case 11:
            return "Ноябрь"
        default:
            return "Декабрь"
        }
    }

    var monthNumber: Int{
        let str = self.printDate(format: "M")
        return Int(str)!
    }

    //число
    var dayNumber: String {
        return self.printDate(format: "d")
    }

    //номер дня в неделе
    var nameDayMonth: Int {
        return Int(self.printDate(format: "e"))!
    }

    //это выходной

    var isWeekend: Bool {
        return self.nameDayMonth > 5
    }

    //получение всех дней в месяце

    func daysArrayDate(yerar: Int, month: Int) -> [Date]{
        let array: [Int] = [Int](1...self.countDayInMonth)

        return array.compactMap({Date(day: $0, month: month, year: yerar)})
    }


    var isTooDay: Bool {
        return Calendar.current.isDateInToday(self)
    }

    //необходимо для того, что бы после выбора диапазона привести к нормальному формату

    var filterNormFormat: String{

        let day = self.printDate(format: "yyyy-MM-dd")
        return day + "T00:00:00Z"
    }

}
