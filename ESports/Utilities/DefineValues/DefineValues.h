//
//  DefineValues.h
//  ESports
//
//  Created by Peter Lee on 14-4-24.
//  Copyright (c) 2014年 Peter Lee. All rights reserved.
//

#ifndef ESports_DefineValues_h
#define ESports_DefineValues_h

#define CustomAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

#define READ_PLIST(plistFileName) [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plistFileName ofType:@"plist"]]

/*###########################################################################################################
 #################################################THE BEGIN##################################################
 ###########################################################################################################*/
    #define UserDefaults [NSUserDefaults standardUserDefaults]
    #define NotificationCenter [NSNotificationCenter defaultCenter]
    #define myAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])
    #define currentWindow [(AppDelegate *)[[UIApplication sharedApplication] delegate] window]

    #define HexColor(color) [UIColor colorWithRed:((float)(((color) & 0xFF0000) >> 16))/255.0 green:((float)(((color) & 0xFF00) >> 8))/255.0 blue:((float)((color) & 0xFF))/255.0 alpha:1.0]
    #define RGBColor(R, G, B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]

    #define AppSelectedColor HexColor(0x6ed4ff)
    #define AppNormalColor [[UIColor whiteColor] colorWithAlphaComponent:0.5]


    // block self
    #define WEAK_SELF __weak typeof(self) weakSelf = self;
    #define STRONG_SELF __strong typeof(weakSelf) strongSelf = weakSelf;

    /*************************************常用方法***************************************/
    #define PNG_NAME(png_name) [UIImage imageNamed:png_name]

    #define VOID_BLOCK  void(^)(void)
    #define GLOBAL_GCD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
    #define MAIN_GCD(block) dispatch_async(dispatch_get_main_queue(),block)

    /*************************************System info***************************************/
    #define FILE_UPLOAD_URL             @"file_upload_url"
    #define IMAGE_COMORESSION           @"ImageCompression"
    #define PING_SERVER_TIME_LNTERVAL   @"pingServerTimeInterval"
    /*************************************User info***************************************/
    //get the left top origin's x,y of a view
    #define VIEW_TX(view) (view.frame.origin.x)
    #define VIEW_TY(view) (view.frame.origin.y)
    //get the width size of the view:width,height
    #define VIEW_W(view)  (view.frame.size.width)
    #define VIEW_H(view)  (view.frame.size.height)
    //get the right bottom origin's x,y of a view
    #define VIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
    #define VIEW_BY(view) (view.frame.origin.y + view.frame.size.height )
    //get the x,y of the frame
    #define FRAME_TX(frame)  (frame.origin.x)
    #define FRAME_TY(frame)  (frame.origin.y)
    //get the size of the frame
    #define FRAME_W(frame)  (frame.size.width)
    #define FRAME_H(frame)  (frame.size.height)

    #define BOUNDS_W(bounds)  (bounds.size.width)
    #define BOUNDS_H(bounds)  (bounds.size.height)
    /*************************************User info***************************************/
    #define USER_ACCOUNT        @"user_account"
    #define USER_DEVICE_TOKEN   @"user_deviceToken"
    #define LOGIN_USER_BARD_JID     @"login_user_bare_jid"
    #define LOGIN_USER_CURRENT_PROJECT_ID     @"login_user_current_project_id"

    #define bound [ UIScreen mainScreen ].bounds
    #define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    #define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
    #define IOS_VERSION_ABOVE(version) (([[[UIDevice currentDevice] systemVersion] floatValue] >= (version))? YES:NO)
    #define IOS_VERSION_BELOW(version) (([[[UIDevice currentDevice] systemVersion] floatValue] < (version))? YES:NO)
/*************************************log system***************************************/
/*************************************log system***************************************/
#ifdef DEBUG
#define LOG_HERE NSLog(@"<%@(line:%d method:%@)>:\n(null)\n<%@ %@>",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,[NSString stringWithUTF8String:__func__],[NSString stringWithUTF8String:__DATE__],[NSString stringWithUTF8String:__TIME__])
#define LOG(FORMAT,...)  NSLog(@"<%@(line:%d method:%@)>:\n%@\n<%@ %@>",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,[NSString stringWithUTF8String:__func__], (FORMAT ? [NSString stringWithFormat:(FORMAT), ##__VA_ARGS__]:@"nil"),[NSString stringWithUTF8String:__DATE__],[NSString stringWithUTF8String:__TIME__])
#else
#define LOG_HERE nil
#define LOG(FORMAT,...) nil
#endif
/*************************************local string method***************************************/
/**
 *  How to use this function ? ? ?
 *
 *  Answer:We should input the key value of the string which we want get,If you create a .string file use this calss we current used,the fileName
 *         will been nil or you can input its name also , else you should input the .string name as you created
 *
 *  @param Key      The key value we setted for the string we want
 *  @param fileName The .string file name you created for
 *
 *  @return The local string we want get
 */
#ifndef KissnappLocalizedString
    #define KissnappLocalizedString(Key,fileName) NSLocalizedStringFromTable((Key),(fileName) ? :[NSString stringWithUTF8String:object_getClassName(self)] , nil)
#endif

/*************************************启动信息和页面跳转***************************************/
    #define EMAIL_REGISTER_SUCCEED @"email_register_succeed"
    #define EMAIL_REGISTER_FAILED @"email_register_failed"
    #define KISSNAPP_QR_HEADER @"http://www.zzt8888.com/?"

/*************************************other***************************************/
    #ifndef IQElement
            #define IQElement NSXMLElement
    #endif

    #ifndef ChildElement
            #define ChildElement NSXMLElement
    #endif
/*************************************导航返回按钮***************************************/
    #define SET_BACK_BUTTON if (self.navigationController) {\
                                UIBarButtonItem * backBtn = [[UIBarButtonItem alloc]init];\
                                backBtn.title = @"";\
                                self.navigationItem.backBarButtonItem = backBtn;\
                            }

    #define degreesToRadians(x) (M_PI*(x)/180.0)

#pragma mark - inline functions

CG_INLINE CGRect CGRectMakeWithCenter(CGPoint center, CGFloat width, CGFloat height);

#pragma mark - Definitions of inline functions.
CG_INLINE CGRect CGRectMakeWithCenter(CGPoint center, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = center.x-0.5*width;
    rect.origin.y = center.y-0.5*height;
    rect.size.width = width;
    rect.size.height = height;
    return rect;
}
#endif
