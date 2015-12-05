//
//  MedicineCollectionController.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/1.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

class MedicineCollectionController: UIViewController {
    
    
    @IBOutlet weak var medicineTableView: UITableView!
    
    let index = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        medicineTableView.dataSource = self
        medicineTableView.delegate = self
        medicineTableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().postNotificationName("currentIndex", object: nil, userInfo: ["index": index])
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

extension MedicineCollectionController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("medicineCell", forIndexPath: indexPath)
        cell.textLabel?.text = "美西律"
        cell.detailTextLabel?.text = "正大天晴药业"
        return cell
    }
}

extension MedicineCollectionController: UITableViewDelegate {


}
