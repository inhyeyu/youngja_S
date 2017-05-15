//
//  TimeUtil.swift
//  youngjaS
//
//  Created by Shatra on 2017. 4. 17..
//  Copyright © 2017년 BWG. All rights reserved.
//

import Foundation
import UIKit

class TimeUtil {
    
    class func createFormatStr(string: String) -> String {
        let formatDate:Date = TimeUtil.createDate(fromString: string)
        let calendar = Calendar.current
 
        let components = calendar.dateComponents([.day, .month, .year], from: formatDate)
        var returnStr:String = ""
        
        if let year = components.year , let month = components.month, let day = components.day {
            var monthStr = "\(month)"
            var dayStr = "\(day)"
            if monthStr.characters.count == 1 {
                monthStr = "0" + monthStr
            }
            if dayStr.characters.count == 1 {
                dayStr = "0" + dayStr
            }
            returnStr = "\(year)" + "." + monthStr + "." + dayStr
        }
        
        return returnStr
    }
    
    class func createDate(fromString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = dateFormatter.date(from: fromString) else {
            return Date()
        }
        
        return date
    }
    
    class func calcRemainDate(targetDate: Date) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: targetDate, to: currentDate)
        
        if let betweenDay = components.day {
            if (betweenDay < 1) {
                if let betweenHour = components.hour {
                    if (betweenHour < 1) {
                        if let betweenMinute = components.minute {
                            if (betweenMinute < 1) {
                                return "방금 전"
                            } else {
                                return "\(betweenMinute)" + "분 전"
                            }
                        }
                    } else {
                        return "\(betweenHour)" + "시간 전"
                    }
                }
            } else {
                return "\(betweenDay)" + "일 전"
            }
        }
        
        return ""
    }
}
