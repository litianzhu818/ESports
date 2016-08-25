//
//  NSObject+Custom.h
//  Kissnapp
//
//  Created by Peter Lee on 15/4/8.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (Custom)

#pragma mark Tip M
- (NSString *)tipFromError:(NSError *)error;
- (void)showError:(NSError *)error;
- (void)showSuccessMessage:(NSString *)message;
- (void)showHudMessage:(NSString *)message;
- (void)showHudMessage:(NSString *)message inView:(UIView *)inView;
- (void)showStatusBarQueryStr:(NSString *)tipStr;
- (void)showStatusBarSuccessStr:(NSString *)tipStr;
- (void)showStatusBarError:(NSError *)error;
- (void)showStatusBarProgress:(CGFloat)progress;
- (void)hideStatusBarProgress;

#pragma mark NetError
- (id)handleResponse:(id)responseJSON;
- (id)handleResponse:(id)responseJSON error:(NSError **)error;
- (id)handlePostResponse:(id)responseJSON error:(NSError **)error;
- (void)clearUnusedCellWithTableView:(UITableView *)tableView;

#pragma mark - UIAlertView

- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
           cancelBlock:(void (^)(void))cancelBlock;

- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitle:(NSString *)otherButtonTitle
           cancelBlock:(void (^)(void))cancelBlock
            otherBlock:(void (^)(void))otherBlock;


#pragma mark methods
- (CGSize)sizeOfLabelWithString:(NSString *)string font:(UIFont *)font height:(CGFloat)height;
- (CGSize)sizeOfLabelWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;

// 产品能够特殊字符串解析出时间例如@"/Date(1469059200000)/"
- (NSDate *)dateWithSpecialDateSring:(NSString *)specialDateSring;

- (NSInteger)currentIndexWithMatchZoneId:(NSString *)matchZoneId;
- (NSString *)currentMatchZoneIdWithIndex:(NSInteger)index;

@end
