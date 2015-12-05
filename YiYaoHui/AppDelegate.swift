//
//  AppDelegate.swift
//  YiYaoHui
//
//  Created by 高永效 on 15/11/29.
//  Copyright © 2015年 EgeTart. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UITabBar.appearance().tintColor = UIColor(red: 150.0 / 255.0, green: 118.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UISearchBar.appearance().setSearchFieldBackgroundImage(UIImage(named: "searchBG"), forState: UIControlState.Normal)
        
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "leftArrow")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "leftArrow")
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        /**
        *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
        *  在将生成的AppKey传入到此方法中。
        *  方法中的第二个参数用于指定要使用哪些社交平台，以数组形式传入。第三个参数为需要连接社交平台SDK时触发，
        *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
        *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
        */
        ShareSDK.registerApp("iosv1101",
            activePlatforms : [SSDKPlatformType.TypeSinaWeibo.rawValue,
                SSDKPlatformType.SubTypeWechatSession.rawValue,
                SSDKPlatformType.SubTypeWechatTimeline.rawValue,
            ],
            onImport: {(platform : SSDKPlatformType) -> Void in
                switch platform
                {
                case SSDKPlatformType.TypeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                case SSDKPlatformType.TypeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                default:
                    break
                }
            },
            onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
                switch platform
                {
                case SSDKPlatformType.TypeSinaWeibo:
                    //------------by HM
                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                    appInfo.SSDKSetupSinaWeiboByAppKey("1267340083",
                        appSecret : "cea26655bf867c95a051927054e60bc5",
                        redirectUri : "http://www.rippletec.net",
                        authType : SSDKAuthTypeBoth)
                    break
                    
                case SSDKPlatformType.TypeWechat:
                    //设置微信应用信息---------by HM
                    appInfo.SSDKSetupWeChatByAppId("wxc29f77bfd5dadced", appSecret: "b40098c53ae73c7e609bd225077f7335")
                    break

                default:
                    break
                }
        })

        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

