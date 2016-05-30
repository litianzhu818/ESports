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
-(id)handleResponse:(id)responseJSON;

- (void)clearUnusedCellWithTableView:(UITableView *)tableView;

@end
