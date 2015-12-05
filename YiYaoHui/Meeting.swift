//
//  Meeting.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/12/1.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

//{
//    "commitDate": "2015-10-23",
//    "content": "6月21日-23日，由中国医药物资协会、世界中医药学会联合会、世界自然基金会/东亚野生物贸易研究组织共同主办，由道地药材国际贸易联盟、吉林省泽康药业有限公司承办的第二届道地药材产业论坛在吉林省吉林市举行。 国家食品药品监督管理局原副局长、道地药材国际贸易联盟名誉理事长任德权、国家中医药管理局原副局长、世界中医药学会联合会副主席兼秘书长李振吉、中国医药物资协会常务副会长兼秘书长刘忠良等领导以及来自俄罗斯、欧洲、马来西亚、香港、台湾等海外嘉宾，国内中药材生产种植经营企业董事长、总经理等百余位业内人士出席了本次会议。会议由道地药材国际贸易联盟常务副秘书长韦绍峰主持。 任德权在论坛开幕前作重要讲话。他说，中医药是全球发展最为成功的传统医药，道地药材则是中医药的精华之一。多年来，国家食品药品监督管理局等有关部门十分重视道地药材的发展，也取得了非常显著的成绩。",
//    "enterpriseName": "石药集团有限公司",
//    "id": 10,
//    "name": "第二届道地药材产业论坛在吉林举行",
//    "pageUrl": "http://www.e-cspc.com/news_company_detail.aspx?id=789&NewsID=6"
//},

import Foundation

class Meeting {
    
    var content = ""
    var name = ""
    var id = ""
    var enterpriseName = ""
    var commitDate = ""
    var pageURL = ""
    
    init(meeting: Dictionary<String, AnyObject>) {
        
        content = meeting["content"] as! String
        name = meeting["name"] as! String
        id = meeting["id"]!.description!
        enterpriseName = meeting["enterpriseName"] as! String
        commitDate = meeting["commitDate"] as! String
        pageURL = meeting["pageUrl"] as! String
    }

}