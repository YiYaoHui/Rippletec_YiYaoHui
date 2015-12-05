//
//  Enterprises.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/30.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

struct Enterprise {
    var id = ""
    var name = ""
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

class Enterprises {
    
    let baseURL = "http://112.74.131.194:8080/MedicineProject/App/res/getEnterprise"
    var enterpriseType = ""
    var parameters: Dictionary<String, String>!
    var enterpriseGroup = [String: [Enterprise]]()

    var enterprises = [Enterprise]()
    
    init(enterpriseType: String) {
        self.enterpriseType = enterpriseType
        parameters = ["currentPage": "0", "size": "0", "type": enterpriseType]
        getEnterprises()
    }
    
    func getEnterprises() {
    
        Alamofire.request(.POST, baseURL, parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (_, _, result) -> Void in
            
            if result.value != nil {
                let enterprises = result.value!["Enterprises"] as! [[String: AnyObject]]
                for element in enterprises {
                    let enterprise = Enterprise(id: element["id"]!.description, name: element["name"]!.description)
                    self.enterprises.append(enterprise)
                }
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.groupEnterprises()
                })
            }
            else {
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    NSNotificationCenter.defaultCenter().postNotificationName("FinishedLoad", object: nil, userInfo: ["result": "failure"])
                })
            }
        }
    }
    
    func groupEnterprises() {
        for enterprise in enterprises {
            let mutableString = NSMutableString(string: enterprise.name)
            CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
            let key = mutableString.substringToIndex(1).uppercaseString
            
            if var enterpriseValue = enterpriseGroup[key] {
                enterpriseValue.append(enterprise)
                enterpriseGroup[key] = enterpriseValue
            }
            else {
                enterpriseGroup[key] = [enterprise]
            }
        }
        NSNotificationCenter.defaultCenter().postNotificationName("FinishedLoad", object: nil, userInfo: ["result": "success"])
    }

}
