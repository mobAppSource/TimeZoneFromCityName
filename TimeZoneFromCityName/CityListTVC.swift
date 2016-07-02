//
//  CityListTVC.swift
//  TimeZoneFromCityName
//
//  Created by Master on 7/2/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class CityListTVC: UITableViewController {

    
    var cityNames: [[String]] = []
    private let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        self.navigationItem.title = "City List"
        self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        
        self.tableView.registerClass(cityCell.self, forCellReuseIdentifier: cellID)
        
        self.readData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if cityNames.count == 0{
            return 1
        }else{
            return cityNames.count
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! cityCell

        // Configure the cell...
        if cityNames.count == 0{
            cell.textLabel?.text = "No result"
        }else{
            cell.cityName.text = cityNames[indexPath.row][0]
            cell.cityAddrName.text = cityNames[indexPath.row][1]
            if let timezone = NSTimeZone(name: cityNames[indexPath.row][1])
            {
                let strArr = timezone.description.componentsSeparatedByString(" ")
                cell.timeZone.text = strArr[1]
            }
        }
        return cell
    }
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Total \(cityNames.count) cities"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CityListTVC{
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    //
    //Read .plist file contents
    func readData()
    {
        
        if let path = NSBundle.mainBundle().pathForResource("timeZoneList", ofType: ".plist"){
            myDicData = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDicData!["TimeZones"] as? NSDictionary{
            
            for (key, value) in dict
            {
                var cityName: [String] = []
                cityName.append(key as! String)
                cityName.append(value as! String)
                cityNames.append(cityName)
            }
            cityNames.sortInPlace({ (one, two) -> Bool in
                return one[0] < two[0]
            })
            self.tableView.reloadData()
        }
        
    }
    func switchKey<T, U>(inout myDict: [T:U], fromKey: T, toKey: T) {
        if let entry = myDict.removeValueForKey(fromKey) {
            myDict[toKey] = entry
        }
    }
}

class cityCell: UITableViewCell{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cityName: UILabel = {
        let label = UILabel()
        label.textAlignment = .Left
        label.font = UIFont.boldSystemFontOfSize(17)
        label.textColor = UIColor.blackColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityAddrName: UILabel = {
        let label = UILabel()
        label.textAlignment = .Left
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timeZone: UILabel = {
        let label = UILabel()
        label.textAlignment = .Right
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews()
    {
        addSubview(cityName)
        addSubview(cityAddrName)
        addSubview(timeZone)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cityName]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cityAddrName]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": timeZone]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[v0]-3-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": cityName, "v1": cityAddrName]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": timeZone]))
    }
}