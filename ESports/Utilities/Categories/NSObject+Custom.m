//
//  NSObject+Custom.m
//  Kissnapp
//
//  Created by Peter Lee on 15/4/8.
//  Copyright (c) 2015年 AFT. All rights reserved.
//

#import "NSObject+Custom.h"
#import "JDStatusBarNotification.h"
#import "MBProgressHUD+Custom.h"
#import "NetworkAPIs.h"
#import "AppDelegate.h"

#import <BlocksKit/UIAlertView+BlocksKit.h>

#define AFTKeyWindow [[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] view]

@implementation NSObject (Custom)

#pragma mark Tip M
- (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if ([error.userInfo objectForKey:@"msg"]) {
            NSArray *msgArray = [[error.userInfo objectForKey:@"msg"] allValues];
            NSUInteger num = [msgArray count];
            for (int i = 0; i < num; i++) {
                NSString *msgStr = [msgArray objectAtIndex:i];
                if (i+1 < num) {
                    [tipStr appendString:[NSString stringWithFormat:@"%@\n", msgStr]];
                }else{
                    [tipStr appendString:msgStr];
                }
            }
        }else{
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else{
                [tipStr appendFormat:@"ErrorCode%ld", (long)error.code];
            }
        }
        return tipStr;
    }
    return nil;
}
- (void)showError:(NSError *)error{
    if ([JDStatusBarNotification isVisible]) {//如果statusBar上面正在显示信息，则不再用hud显示error
        NSLog(@"如果statusBar上面正在显示信息，则不再用hud显示error");
        return;
    }
    NSString *tipStr = [self tipFromError:error];
    [self showHudMessage:tipStr];
}
- (void)showSuccessMessage:(NSString *)message
{
    if (message && message.length > 0) {
        [MBProgressHUD showSuccess:message toView:AFTKeyWindow];
    }
}
- (void)showHudMessage:(NSString *)message
{
    if (message && message.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:AFTKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0];
    }
}
- (void)showHudMessage:(NSString *)message inView:(UIView *)inView
{
    if (message && message.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0];
    }
}
- (void)showStatusBarQueryStr:(NSString *)tipStr{
    [JDStatusBarNotification showWithStatus:tipStr styleName:JDStatusBarStyleSuccess];
    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
}
- (void)showStatusBarSuccessStr:(NSString *)tipStr{
    if ([JDStatusBarNotification isVisible]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
            [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.5 styleName:JDStatusBarStyleSuccess];
        });
    }else{
        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
        [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.0 styleName:JDStatusBarStyleSuccess];
    }
}
- (void)showStatusBarError:(NSError *)error{
    if ([JDStatusBarNotification isVisible]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
            [JDStatusBarNotification showWithStatus:[self tipFromError:error] dismissAfter:1.5 styleName:JDStatusBarStyleError];
        });
    }else{
        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
        [JDStatusBarNotification showWithStatus:[self tipFromError:error] dismissAfter:1.5 styleName:JDStatusBarStyleError];
    }
}
- (void)showStatusBarProgress:(CGFloat)progress{
    [JDStatusBarNotification showProgress:progress];
    
}
- (void)hideStatusBarProgress{
    [JDStatusBarNotification showProgress:0.0];
}

#pragma mark - NetError
-(id)handleResponse:(id)responseJSON{
    NSError *error = nil;
    //code为非0值时，表示有错
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"code"];
    
    if (resultCode.intValue != 0) {
        error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@",BaseURL] code:resultCode.intValue userInfo:responseJSON];
        [self showError:error];
    }
    return error;
}

- (void)clearUnusedCellWithTableView:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - UIAlertView

- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
           cancelBlock:(void (^)(void))cancelBlock
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:nil, nil];
    [alertView bk_setCancelBlock:cancelBlock];
    [alertView show];
}

- (void)showAlertTitle:(NSString *)title
               message:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButtonTitle
      otherButtonTitle:(NSString *)otherButtonTitle
           cancelBlock:(void (^)(void))cancelBlock
            otherBlock:(void (^)(void))otherBlock
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:otherButtonTitle, nil];
    [alertView bk_setCancelBlock:cancelBlock];
    [alertView bk_setHandler:otherBlock forButtonAtIndex:1];
    [alertView show];
}

@end
