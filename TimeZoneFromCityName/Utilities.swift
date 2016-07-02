//
//  Utilities.swift
//  TimeZoneFromCityName
//
//  Created by Master on 7/2/16.
//  Copyright © 2016 Master. All rights reserved.
//

import Foundation
import UIKit

//get the timezone data from city name
func getTimeFromCityName(city_name: String) -> String
{
    var retString: String!
    let locTime = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    
    if let cityTimeZone = NSTimeZone(name: city_name){
        formatter.timeZone = cityTimeZone
    }
    formatter.timeStyle = .MediumStyle
    retString = formatter.stringFromDate(locTime)
    return retString
}

// get local time
func getLocalTime() -> String
{
    let timeFormatter = NSDateFormatter()
    timeFormatter.dateFormat = "HH:mm:ss"
    timeFormatter.timeStyle = .MediumStyle
    return timeFormatter.stringFromDate(NSDate())
}