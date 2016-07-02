//
//  AnalogClockVC.swift
//  TimeZoneFromCityName
//
//  Created by Master on 7/2/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit
import BEMAnalogClock

class AnalogClockVC: UIViewController {

    var cityName: String!
    var viewTitle: String!
    
    var clockView: BEMAnalogClockView!
    let clockTime: UILabel = UILabel(frame: CGRect(x: wView/2 - 70, y: 90, width: 140, height: 20))
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.clockView.realTime = false
        self.clockView.stopRealTime()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.clockView.realTime = true
        self.clockView.startRealTime()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.viewTitle
        self.view.backgroundColor = UIColor.whiteColor()
        self.clockView = BEMAnalogClockView(frame: CGRect(x: 40, y: hView/2 - (wView - 80)/2, width: wView - 80, height: wView - 80))
        
        self.dispAnalogClock()
        self.dispTime()
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(AnalogClockVC.updateTime), userInfo: nil, repeats: true)
    }
    //
    func updateTime()
    {
        self.clockTime.text = getTimeFromCityName(self.cityName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dispTime()
    {
        let clockName: UILabel = UILabel(frame: CGRect(x: wView/2 - 90, y: 60, width: 180, height: 20))
        clockName.textColor = UIColor.redColor()
        clockName.textAlignment = .Center
        clockName.text = self.cityName
        clockName.font = UIFont.boldSystemFontOfSize(17)
        self.view.addSubview(clockName)
        
        
        clockTime.text = getTimeFromCityName(self.cityName)
        clockTime.textAlignment = .Center
        clockTime.textColor = UIColor.blueColor()
        clockTime.font = UIFont.boldSystemFontOfSize(17)
        
        self.view.addSubview(clockTime)
        
    }
    func dispAnalogClock()
    {
        let timeStrArr = getTimeFromCityName(cityName).componentsSeparatedByString(":")
        let secAndAPM = timeStrArr[2].componentsSeparatedByString(" ")
        
        clockView.delegate = self
        clockView.borderColor = UIColor.blackColor()
        clockView.realTime = true
        clockView.startRealTime()
        clockView.hours = Int(timeStrArr[0])!
        clockView.hourHandLength = (self.view.frame.size.width - 80) * 0.4
        clockView.minutes = Int(timeStrArr[1])!
        clockView.minuteHandLength = (self.view.frame.size.width - 80) * 0.45
        clockView.seconds = Int(secAndAPM[0])!
        clockView.secondHandLength = (self.view.frame.size.width - 80) * 0.5
        clockView.enableDigit = true
        clockView.enableShadows = true
        clockView.userInteractionEnabled = false
        clockView.multipleTouchEnabled = false
        clockView.updateTimeAnimated(true)
        print(timeStrArr)
        self.view.addSubview(clockView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//BEMAnalogClockView delegate
extension AnalogClockVC: BEMAnalogClockDelegate{
    func analogClock(clock: BEMAnalogClockView!, graduationLengthForIndex index: Int) -> CGFloat {
        if index % 10 == 0{
            return 20
        }else if index % 5 == 0{
            return 10
        }else{
            return 3
        }
    }
    func currentTimeOnClock(clock: BEMAnalogClockView!, hours: String!, minutes: String!, seconds: String!) {
        self.clockTime.text = "\(hours): \(minutes): \(seconds)"
        print("\(hours): \(minutes): \(seconds)")
    }
}
extension AnalogClockVC{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}